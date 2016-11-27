# MySQL Connector/Python - MySQL driver written in Python.
# Copyright (c) 2009, 2014, Oracle and/or its affiliates. All rights reserved.

# MySQL Connector/Python is licensed under the terms of the GPLv2
# <http://www.gnu.org/licenses/old-licenses/gpl-2.0.html>, like most
# MySQL Connectors. There are special exceptions to the terms and
# conditions of the GPLv2 as it is applied to this software, see the
# FOSS License Exception
# <http://www.mysql.com/about/legal/licensing/foss-exception.html>.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

"""Implements the MySQL Client/Server protocol
"""

import struct
import datetime
from decimal import Decimal

try:
    from hashlib import sha1
except ImportError:
    from sha import new as sha1

from mysql.connector.constants import (FieldFlag, ServerCmd, FieldType)
from mysql.connector import (errors, utils)


class MySQLProtocol(object):
    """
    Implemets MySQL client/server protocol.
    Creates and parse packets based on MySQL client/server protocol.
    """
    def _scramble_password(self, passwd, seed):
        """Scramble a password ready to send to MySQL"""
        hash4 = None
        try:
            hash1 = sha1(passwd).digest()
            hash2 = sha1(hash1).digest()  # Password as found in mysql.user()
            hash3 = sha1(seed + hash2).digest()
            xored = [utils.intread(h1) ^ utils.intread(h3)
                for (h1, h3) in zip(hash1, hash3)]
            hash4 = struct.pack('20B', *xored)
        except Exception as err:
            raise errors.InterfaceError(
                'Failed scrambling password; %s' % err)

        return hash4

    def _prepare_auth(self, usr, pwd, dbname, flags, seed):
        """Prepare elements of the authentication packet"""

        if usr is not None and len(usr) > 0:
            if isinstance(usr, unicode):
                usr = usr.encode('utf8')
            _username = usr + '\x00'
        else:
            _username = '\x00'

        if pwd is not None and len(pwd) > 0:
            if isinstance(pwd, unicode):
                pwd = pwd.encode('utf8')
            _password = utils.int1store(20) +\
                self._scramble_password(pwd, seed)
        else:
            _password = '\x00'

        if dbname is not None and len(dbname):
            _database = dbname.encode('utf8') + '\x00'
        else:
            _database = '\x00'

        return (_username, _password, _database)

    def make_auth(self, seed, username=None, password=None, database=None,
                  charset=33, client_flags=0,
                  max_allowed_packet=1073741824):
        """Make a MySQL Authentication packet"""
        if not seed:
            raise errors.ProgrammingError('Seed missing')

        auth = self._prepare_auth(username, password, database,
                                  client_flags, seed)
        return utils.int4store(client_flags) +\
               utils.int4store(max_allowed_packet) +\
               utils.int1store(charset) +\
               '\x00' * 23 + auth[0] + auth[1] + auth[2]

    def make_auth_ssl(self, charset=33, client_flags=0,
                      max_allowed_packet=1073741824):
        """Make a SSL authentication packet"""
        return utils.int4store(client_flags) +\
               utils.int4store(max_allowed_packet) +\
               utils.int1store(charset) +\
               '\x00' * 23

    def make_command(self, command, argument=None):
        """Make a MySQL packet containing a command"""
        data = utils.int1store(command)
        if argument is not None:
            data += str(argument)
        return data

    def make_change_user(self, seed, username=None, password=None,
                         database=None, charset=33, client_flags=0):
        """Make a MySQL packet with the Change User command"""
        if not seed:
            raise errors.ProgrammingError('Seed missing')

        auth = self._prepare_auth(username, password, database,
                                  client_flags, seed)
        data = utils.int1store(ServerCmd.CHANGE_USER) +\
               auth[0] + auth[1] + auth[2] + utils.int2store(charset)
        return data

    def parse_handshake(self, packet):
        """Parse a MySQL Handshake-packet"""
        res = {}
        (packet, res['protocol']) = utils.read_int(packet[4:], 1)
        (packet, res['server_version_original']) = utils.read_string(
            packet, end='\x00')
        (packet, res['server_threadid']) = utils.read_int(packet, 4)
        (packet, res['scramble']) = utils.read_bytes(packet, 8)
        packet = packet[1:]  # Filler 1 * \x00
        (packet, res['capabilities']) = utils.read_int(packet, 2)
        (packet, res['charset']) = utils.read_int(packet, 1)
        (packet, res['server_status']) = utils.read_int(packet, 2)
        packet = packet[13:]  # Filler 13 * \x00
        (packet, scramble_next) = utils.read_bytes(packet, 12)
        res['scramble'] += scramble_next
        return res

    def parse_ok(self, packet):
        """Parse a MySQL OK-packet"""
        if not packet[4] == '\x00':
            raise errors.InterfaceError("Failed parsing OK packet.")

        ok_packet = {}
        try:
            ok_packet['field_count'] = struct.unpack('<xxxxB', packet[0:5])[0]
            (packet, ok_packet['affected_rows']) = utils.read_lc_int(packet[5:])
            (packet, ok_packet['insert_id']) = utils.read_lc_int(packet)
            (ok_packet['server_status'],
                ok_packet['warning_count']) = struct.unpack('<HH', packet[0:4])
            packet = packet[4:]
            if packet:
                (packet, ok_packet['info_msg']) = utils.read_lc_string(packet)
        except ValueError:
            raise errors.InterfaceError("Failed parsing OK packet.")
        return ok_packet

    def parse_column_count(self, packet):
        """Parse a MySQL packet with the number of columns in result set"""
        try:
            return utils.read_lc_int(packet[4:])[1]
        except (struct.error, ValueError):
            raise errors.InterfaceError("Failed parsing column count")

    def parse_column(self, packet):
        """Parse a MySQL column-packet"""
        (packet, _) = utils.read_lc_string(packet[4:]) # catalog
        (packet, _) = utils.read_lc_string(packet)  # db
        (packet, _) = utils.read_lc_string(packet)  # table
        (packet, _) = utils.read_lc_string(packet)  # org_table
        (packet, name) = utils.read_lc_string(packet)  # name
        (packet, _) = utils.read_lc_string(packet)  # org_name

        try:
            (_, _, field_type,
             flags, _) = struct.unpack('<xHIBHBxx', packet)
        except struct.error:
            raise errors.InterfaceError("Failed parsing column information")

        return (
            name,
            field_type,
            None,  # display_size
            None,  # internal_size
            None,  # precision
            None,  # scale
            ~flags & FieldFlag.NOT_NULL,  # null_ok
            flags,  # MySQL specific
            )

    def parse_eof(self, packet):
        """Parse a MySQL EOF-packet"""
        err_msg = "Failed parsing EOF packet."
        res = {}
        try:
            unpacked = struct.unpack('<xxxBBHH', packet)
        except struct.error:
            raise errors.InterfaceError(err_msg)

        if not (unpacked[1] == 254 and len(packet) <= 9):
            raise errors.InterfaceError(err_msg)

        res['warning_count'] = unpacked[2]
        res['status_flag'] = unpacked[3]
        return res

    def parse_statistics(self, packet):
        """Parse the statistics packet"""
        errmsg = "Failed getting COM_STATISTICS information"
        res = {}
         # Information is separated by 2 spaces
        pairs = packet[4:].split('\x20\x20')
        for pair in pairs:
            try:
                (lbl, val) = [v.strip() for v in pair.split(':', 2)]
            except:
                raise errors.InterfaceError(errmsg)

            # It's either an integer or a decimal
            try:
                res[lbl] = long(val)
            except:
                try:
                    res[lbl] = Decimal(val)
                except:
                    raise errors.InterfaceError(
                        "%s (%s:%s)." % (errmsg, lbl, val))
        return res

    def read_text_result(self, sock, count=1):
        """Read MySQL text result

        Reads all or given number of rows from the socket.

        Returns a tuple with 2 elements: a list with all rows and
        the EOF packet.
        """
        rows = []
        eof = None
        rowdata = None
        i = 0
        while True:
            if eof is not None:
                break
            if i == count:
                break
            packet = sock.recv()
            if packet.startswith('\xff\xff\xff'):
                datas = [packet[4:]]
                packet = sock.recv()
                while packet.startswith('\xff\xff\xff'):
                    datas.append(packet[4:])
                    packet = sock.recv()
                if packet[4] == '\xfe':
                    eof = self.parse_eof(packet)
                else:
                    datas.append(packet[4:])
                rowdata = utils.read_lc_string_list(''.join(datas))
            elif packet[4] == '\xfe':
                eof = self.parse_eof(packet)
                rowdata = None
            else:
                eof = None
                rowdata = utils.read_lc_string_list(packet[4:])
            if eof is None and rowdata is not None:
                rows.append(rowdata)
            i += 1
        return (rows, eof)

    def _parse_binary_integer(self, packet, field):
        """Parse an integer from a binary packet"""
        if field[1] == FieldType.TINY:
            format_ = 'b'
            length = 1
        elif field[1] == FieldType.SHORT:
            format_ = 'h'
            length = 2
        elif field[1] in (FieldType.INT24, FieldType.LONG):
            format_ = 'i'
            length = 4
        elif field[1] == FieldType.LONGLONG:
            format_ = 'q'
            length = 8

        if field[7] & FieldFlag.UNSIGNED:
            format_ = format_.upper()

        return (packet[length:], struct.unpack(format_, packet[0:length])[0])

    def _parse_binary_float(self, packet, field):
        """Parse a float/double from a binary packet"""
        if field[1] == FieldType.DOUBLE:
            length = 8
            format_ = 'd'
        else:
            length = 4
            format_ = 'f'

        return (packet[length:], struct.unpack(format_, packet[0:length])[0])

    def _parse_binary_timestamp(self, packet, field):
        """Parse a timestamp from a binary packet"""
        length = ord(packet[0])
        value = None
        if length == 4:
            value = datetime.date(
                year=struct.unpack('H', packet[1:3])[0],
                month=ord(packet[3]),
                day=ord(packet[4]))
        elif length >= 7:
            mcs = 0
            if length == 11:
                mcs = struct.unpack('I', packet[8:length + 1])[0]
            value = datetime.datetime(
                year=struct.unpack('H', packet[1:3])[0],
                month=ord(packet[3]),
                day=ord(packet[4]),
                hour=ord(packet[5]),
                minute=ord(packet[6]),
                second=ord(packet[7]),
                microsecond=mcs)

        return (packet[length + 1:], value)

    def _parse_binary_time(self, packet, field):
        """Parse a time value from a binary packet"""
        length = ord(packet[0])
        data = packet[1:length + 1]
        mcs = 0
        if length > 8:
            mcs = struct.unpack('I', data[8:])[0]
        days = struct.unpack('I', data[1:5])[0]
        if int(ord(data[0])) == 1:
            days *= -1
        tmp = datetime.timedelta(days=days,
                                 seconds=int(ord(data[7])),
                                 microseconds=mcs,
                                 minutes=int(ord(data[6])),
                                 hours=int(ord(data[5])))

        return (packet[length + 1:], tmp)

    def _parse_binary_values(self, fields, packet):
        """Parse values from a binary result packet"""
        null_bitmap_length = (len(fields) + 7 + 2) // 8
        null_bitmap = utils.intread(packet[0:null_bitmap_length])
        packet = packet[null_bitmap_length:]

        values = []
        for pos, field in enumerate(fields):
            if null_bitmap & 1 << (pos + 2):
                values.append(None)
                continue
            elif field[1] in (FieldType.TINY, FieldType.SHORT,
                              FieldType.INT24,
                              FieldType.LONG, FieldType.LONGLONG):
                (packet, value) = self._parse_binary_integer(packet, field)
                values.append(value)
            elif field[1] in (FieldType.DOUBLE, FieldType.FLOAT):
                (packet, value) = self._parse_binary_float(packet, field)
                values.append(value)
            elif field[1] in (FieldType.DATETIME, FieldType.DATE,
                              FieldType.TIMESTAMP):
                (packet, value) = self._parse_binary_timestamp(packet, field)
                values.append(value)
            elif field[1] == FieldType.TIME:
                (packet, value) = self._parse_binary_time(packet, field)
                values.append(value)
            else:
                (packet, value) = utils.read_lc_string(packet)
                values.append(value)

        return tuple(values)

    def read_binary_result(self, sock, columns, count=1):
        """Read MySQL binary protocol result

        Reads all or given number of binary resultset rows from the socket.
        """
        rows = []
        eof = None
        values = None
        i = 0
        while True:
            if eof is not None:
                break
            if i == count:
                break
            packet = sock.recv()
            if packet[4] == '\xfe':
                eof = self.parse_eof(packet)
                values = None
            elif packet[4] == '\x00':
                eof = None
                values = self._parse_binary_values(columns, packet[5:])
            if eof is None and values is not None:
                rows.append(values)
            i += 1
        return (rows, eof)

    def parse_binary_prepare_ok(self, packet):
        """Parse a MySQL Binary Protocol OK packet"""
        if not packet[4] == '\x00':
            raise errors.InterfaceError("Failed parsing Binary OK packet")

        ok_packet = {}
        try:
            (packet, ok_packet['statement_id']) = utils.read_int(packet[5:], 4)
            (packet, ok_packet['num_columns']) = utils.read_int(packet, 2)
            (packet, ok_packet['num_params']) = utils.read_int(packet, 2)
            packet = packet[1:]  # Filler 1 * \x00
            (packet, ok_packet['warning_count']) = utils.read_int(packet, 2)
        except ValueError:
            raise errors.InterfaceError("Failed parsing Binary OK packet")

        return ok_packet

    def _prepare_binary_integer(self, value):
        """Prepare an integer for the MySQL binary protocol"""
        field_type = None
        flags = 0
        if value < 0:
            if value >= -128:
                format_ = 'b'
                field_type = FieldType.TINY
            elif value >= -32768:
                format_ = 'h'
                field_type = FieldType.SHORT
            elif value >= -2147483648:
                format_ = 'i'
                field_type = FieldType.LONG
            else:
                format_ = 'q'
                field_type = FieldType.LONGLONG
        else:
            flags = 128
            if value <= 255:
                format_ = 'B'
                field_type = FieldType.TINY
            elif value <= 65535:
                format_ = 'H'
                field_type = FieldType.SHORT
            elif value <= 4294967295:
                format_ = 'I'
                field_type = FieldType.LONG
            else:
                field_type = FieldType.LONGLONG
                format_ = 'Q'
        return (struct.pack(format_, value), field_type, flags)

    def _prepare_binary_timestamp(self, value):
        """Prepare a timestamp object for the MySQL binary protocol

        This method prepares a timestamp of type datetime.datetime or
        datetime.date for sending over the MySQL binary protocol.
        A tuple is returned with the prepared value and field type
        as elements.

        Raises ValueError when the argument value is of invalid type.

        Returns a tuple.
        """
        if isinstance(value, datetime.datetime):
            field_type = FieldType.DATETIME
        elif isinstance(value, datetime.date):
            field_type = FieldType.DATE
        else:
            raise ValueError(
                "Argument must a datetime.datetime or datetime.date")

        packed = (utils.int2store(value.year) +
                  utils.int1store(value.month) +
                  utils.int1store(value.day))

        if isinstance(value, datetime.datetime):
            packed = (packed + utils.int1store(value.hour) +
                      utils.int1store(value.minute) +
                      utils.int1store(value.second))
            if value.microsecond > 0:
                packed += utils.int4store(value.microsecond)

        packed = utils.int1store(len(packed)) + packed
        return (packed, field_type)

    def _prepare_binary_time(self, value):
        """Prepare a time object for the MySQL binary protocol

        This method prepares a time object of type datetime.timedelta or
        datetime.time for sending over the MySQL binary protocol.
        A tuple is returned with the prepared value and field type
        as elements.

        Raises ValueError when the argument value is of invalid type.

        Returns a tuple.
        """
        if not isinstance(value, (datetime.timedelta, datetime.time)):
            raise ValueError(
                "Argument must a datetime.timedelta or datetime.time")

        field_type = FieldType.TIME
        negative = 0
        mcs = None
        packed = ''

        if isinstance(value, datetime.timedelta):
            if value.days < 0:
                negative = 1
            (hours, remainder) = divmod(value.seconds, 3600)
            (mins, secs) = divmod(remainder, 60)
            packed += (utils.int4store(abs(value.days)) +
                       utils.int1store(hours) +
                       utils.int1store(mins) +
                       utils.int1store(secs))
            mcs = value.microseconds
        else:
            packed += (utils.int4store(0) +
                       utils.int1store(value.hour) +
                       utils.int1store(value.minute) +
                       utils.int1store(value.second))
            mcs = value.microsecond
        if mcs:
            packed += utils.int4store(mcs)

        packed = utils.int1store(negative) + packed
        packed = utils.int1store(len(packed)) + packed

        return (packed, field_type)

    def _prepare_stmt_send_long_data(self, statement, param, data):
        """Prepare long data for prepared statments

        Returns a string.
        """
        packet = (
            utils.int4store(statement) +
            utils.int2store(param) +
            data)
        return packet

    def make_stmt_execute(self, statement_id, data=(), parameters=(),
                          flags=0, long_data_used=None, charset='utf8'):
        """Make a MySQL packet with the Statement Execute command"""
        iteration_count = 1
        null_bitmap = [0] * ((len(data) + 7) // 8)
        values = []
        types = []
        packed = ''
        if long_data_used is None:
            long_data_used = {}
        if parameters and data:
            if len(data) != len(parameters):
                raise errors.InterfaceError(
                    "Failed executing prepared statement: data values does not"
                    " match number of parameters")
            for pos, _ in enumerate(parameters):
                value = data[pos]
                flags = 0
                if value is None:
                    null_bitmap[(pos // 8)] |= 1 << (pos % 8)
                    continue
                elif pos in long_data_used:
                    if long_data_used[pos][0]:
                        # We suppose binary data
                        field_type = FieldType.BLOB
                    else:
                        # We suppose text data
                        field_type = FieldType.STRING
                elif isinstance(value, (int, long)):
                    (packed, field_type,
                     flags) = self._prepare_binary_integer(value)
                    values.append(packed)
                elif isinstance(value, str):
                    values.append(utils.intstore(len(value)) + value)
                    field_type = FieldType.VARCHAR
                elif isinstance(value, unicode):
                    value = value.encode(charset)
                    values.append(utils.intstore(len(value)) + value)
                    field_type = FieldType.VARCHAR
                elif isinstance(value, Decimal):
                    values.append(utils.intstore(len(str(value))) + str(value))
                    field_type = FieldType.DECIMAL
                elif isinstance(value, float):
                    values.append(struct.pack('d', value))
                    field_type = FieldType.DOUBLE
                elif isinstance(value, (datetime.datetime, datetime.date)):
                    (packed, field_type) = self._prepare_binary_timestamp(
                        value)
                    values.append(packed)
                elif isinstance(value, (datetime.timedelta, datetime.time)):
                    (packed, field_type) = self._prepare_binary_time(value)
                    values.append(packed)
                else:
                    raise errors.ProgrammingError(
                        "MySQL binary protocol can not handle "
                        "'{classname}' objects".format(
                            classname=value.__class__.__name__))
                types.append(utils.int1store(field_type) +
                             utils.int1store(flags))

        packet = (
            utils.int4store(statement_id),
            utils.int1store(flags),
            utils.int4store(iteration_count),
            ''.join([struct.pack('B', bit) for bit in null_bitmap]),
            utils.int1store(1),
            ''.join(types),
            ''.join(values)
            )
        return ''.join(packet)
