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

"""Cursor classes
"""

import sys
import weakref
import re
import itertools

from mysql.connector import errors

SQL_COMMENT = r"\/\*.*?\*\/"
RE_SQL_COMMENT = re.compile(
    r'''({0})|(["'`][^"'`]*?({0})[^"'`]*?["'`])'''.format(SQL_COMMENT),
    re.I | re.M | re.S)
RE_SQL_ON_DUPLICATE = re.compile(
    r'''\s*ON\s+DUPLICATE\s+KEY(?:[^"'`]*["'`][^"'`]*["'`])*[^"'`]*$''',
    re.I | re.M | re.S)
RE_SQL_INSERT_STMT = re.compile(
    r"({0}|\s)*INSERT({0}|\s)*INTO.+VALUES.*".format(SQL_COMMENT),
    re.I | re.M | re.S)
RE_SQL_INSERT_VALUES = re.compile(r'.*VALUES\s*(\(.*\)).*', re.I | re.M | re.S)

RE_SQL_SPLIT_STMTS = re.compile(
    r''';(?=(?:[^"'`]*["'`][^"'`]*["'`])*[^"'`]*$)''')
RE_SQL_FIND_PARAM = re.compile(
    r'''%s(?=(?:[^"'`]*["'`][^"'`]*["'`])*[^"'`]*$)''')


class CursorBase(object):
    """
    Base for defining MySQLCursor. This class is a skeleton and defines
    methods and members as required for the Python Database API
    Specification v2.0.

    It's better to inherite from MySQLCursor.
    """

    def __init__(self):
        self._description = None
        self._rowcount = -1
        self._last_insert_id = None
        self.arraysize = 1

    def callproc(self, procname, args=()):
        """Calls a stored procedue with the given arguments

        The arguments will be set during this session, meaning
        they will be called like  _<procname>__arg<nr> where
        <nr> is an enumeration (+1) of the arguments.

        Coding Example:
          1) Definining the Stored Routine in MySQL:
          CREATE PROCEDURE multiply(IN pFac1 INT, IN pFac2 INT, OUT pProd INT)
          BEGIN
            SET pProd := pFac1 * pFac2;
          END

          2) Executing in Python:
          args = (5,5,0) # 0 is to hold pprod
          cursor.callproc('multiply', args)
          print(cursor.fetchone())

        Does not return a value, but a result set will be
        available when the CALL-statement execute successfully.
        Raises exceptions when something is wrong.
        """
        pass

    def close(self):
        """Close the cursor."""
        pass

    def execute(self, operation, params=(), multi=False):
        """Executes the given operation

        Executes the given operation substituting any markers with
        the given parameters.

        For example, getting all rows where id is 5:
          cursor.execute("SELECT * FROM t1 WHERE id = %s", (5,))

        The multi argument should be set to True when executing multiple
        statements in one operation. If not set and multiple results are
        found, an InterfaceError will be raised.

        If warnings where generated, and connection.get_warnings is True, then
        self._warnings will be a list containing these warnings.

        Returns an iterator when multi is True, otherwise None.
        """
        pass

    def executemany(self, operation, seqparams):
        """Execute the given operation multiple times

        The executemany() method will execute the operation iterating
        over the list of parameters in seq_params.

        Example: Inserting 3 new employees and their phone number

        data = [
            ('Jane','555-001'),
            ('Joe', '555-001'),
            ('John', '555-003')
            ]
        stmt = "INSERT INTO employees (name, phone) VALUES ('%s','%s')"
        cursor.executemany(stmt, data)

        INSERT statements are optimized by batching the data, that is
        using the MySQL multiple rows syntax.

        Results are discarded. If they are needed, consider looping over
        data using the execute() method.
        """
        pass

    def fetchone(self):
        """Returns next row of a query result set

        Returns a tuple or None.
        """
        pass

    def fetchmany(self, size=1):
        """Returns the next set of rows of a query result, returning a
        list of tuples. When no more rows are available, it returns an
        empty list.

        The number of rows returned can be specified using the size argument,
        which defaults to one
        """
        pass

    def fetchall(self):
        """Returns all rows of a query result set

        Returns a list of tuples.
        """
        pass

    def nextset(self):
        """Not Implemented."""
        pass

    def setinputsizes(self, sizes):
        """Not Implemeted."""
        pass

    def setoutputsize(self, size, column=None):
        """Not Implemeted."""
        pass

    def reset(self):
        """Reset the cursor to default"""
        pass

    @property
    def description(self):
        """Returns description of columns in a result

        This property returns a list of tuples describing the columns in
        in a result set. A tuple is described as follows::

                (column_name,
                 type,
                 None,
                 None,
                 None,
                 None,
                 null_ok,
                 column_flags)  # Addition to PEP-249 specs

        Returns a list of tuples.
        """
        return self._description

    @property
    def rowcount(self):
        """Returns the number of rows produced or affected

        This property returns the number of rows produced by queries
        such as a SELECT, or affected rows when executing DML statements
        like INSERT or UPDATE.

        Note that for non-buffered cursors it is impossible to know the
        number of rows produced before having fetched them all. For those,
        the number of rows will be -1 right after execution, and
        incremented when fetching rows.

        Returns an integer.
        """
        return self._rowcount

    @property
    def lastrowid(self):
        """Returns the value generated for an AUTO_INCREMENT column

        Returns the value generated for an AUTO_INCREMENT column by
        the previous INSERT or UPDATE statement or None when there is
        no such value available.

        Returns a long value or None.
        """
        return self._last_insert_id


class MySQLCursor(CursorBase):
    """Default cursor for interacting with MySQL

    This cursor will execute statements and handle the result. It will
    not automatically fetch all rows.

    MySQLCursor should be inherited whenever other functionallity is
    required. An example would to change the fetch* member functions
    to return dictionaries instead of lists of values.

    Implements the Python Database API Specification v2.0 (PEP-249)
    """
    def __init__(self, connection=None):
        CursorBase.__init__(self)
        self._connection = None
        self._stored_results = []
        self._nextrow = (None, None)
        self._warnings = None
        self._warning_count = 0
        self._executed = None
        self._executed_list = []
        self._binary = False
        self._lastrowid = None

        if connection is not None:
            self._set_connection(connection)

    def __iter__(self):
        """
        Iteration over the result set which calls self.fetchone()
        and returns the next row.
        """
        return iter(self.fetchone, None)

    def _set_connection(self, connection):
        """Set the connection"""
        try:
            self._connection = weakref.proxy(connection)
            self._connection._protocol  # pylint: disable=W0212,W0104
        except (AttributeError, TypeError):
            raise errors.InterfaceError(errno=2048)

    def _reset_result(self):
        """Reset the cursor to default"""
        self._rowcount = -1
        self._lastrowid = None
        self._nextrow = (None, None)
        self._stored_results = []
        self._warnings = None
        self._warning_count = 0
        self._description = None
        self._executed = None
        self._executed_list = []
        self.reset()

    def _have_unread_result(self):
        """Check whether there is an unread result"""
        try:
            return self._connection.unread_result
        except AttributeError:
            return False

    def next(self):
        """
        Used for iterating over the result set. Calles self.fetchone()
        to get the next row.
        """
        try:
            row = self.fetchone()
        except errors.InterfaceError:
            raise StopIteration
        if not row:
            raise StopIteration
        return row

    def close(self):
        """Close the cursor

        Returns True when successful, otherwise False.
        """
        if self._connection is None:
            return False
        if self._have_unread_result():
            raise errors.InternalError("Unread result found.")

        self._reset_result()
        self._connection = None

        return True

    def _process_params_dict(self, params):
        """Process query parameters given as dictionary"""
        try:
            to_mysql = self._connection.converter.to_mysql
            escape = self._connection.converter.escape
            quote = self._connection.converter.quote
            res = {}
            for key, val in params.items():
                conv = val
                conv = to_mysql(conv)
                conv = escape(conv)
                conv = quote(conv)
                res[key] = conv
        except StandardError as err:
            raise errors.ProgrammingError(
                "Failed processing pyformat-parameters; %s" % err)
        else:
            return res

        return None

    def _process_params(self, params):
        """Process query parameters."""
        if isinstance(params, dict):
            return self._process_params_dict(params)

        try:
            res = params
            # pylint: disable=W0141
            res = map(self._connection.converter.to_mysql, res)
            res = map(self._connection.converter.escape, res)
            res = map(self._connection.converter.quote, res)
            # pylint: enable=W0141
        except StandardError as err:
            raise errors.ProgrammingError(
                "Failed processing format-parameters; %s" % err)
        else:
            return tuple(res)
        return None

    def _row_to_python(self, rowdata, desc=None):
        """Convert the row from MySQL to Python types"""
        res = []
        to_python = self._connection.converter.to_python
        try:
            if not desc:
                desc = self.description
            for flddsc, val in zip(desc, rowdata):
                res.append(to_python(flddsc, val),)
        except StandardError as err:
            raise errors.InterfaceError(
                "Failed converting row to Python types; %s" % err)
        else:
            return tuple(res)

        return None

    def _handle_noresultset(self, res):
        """Handles result of execute() when there is no result set
        """
        try:
            self._rowcount = res['affected_rows']
            self._last_insert_id = res['insert_id']
            self._warning_count = res['warning_count']
        except (KeyError, TypeError) as err:
            raise errors.ProgrammingError(
                "Failed handling non-resultset; %s" % err)

        if self._connection.get_warnings is True and self._warning_count:
            self._warnings = self._fetch_warnings()

    def _handle_resultset(self):
        """Handles result set

        This method handles the result set and is called after reading
        and storing column information in _handle_result(). For non-buffering
        cursors, this method is usually doing nothing.
        """
        pass

    def _handle_result(self, result):
        """
        Handle the result after a command was send. The result can be either
        an OK-packet or a dictionary containing column/eof information.

        Raises InterfaceError when result is not a dict() or result is
        invalid.
        """
        if not isinstance(result, dict):
            raise errors.InterfaceError('Result was not a dict()')

        if 'columns' in result:
            # Weak test, must be column/eof information
            self._description = result['columns']
            self._connection.unread_result = True
            self._handle_resultset()
        elif 'affected_rows' in result:
            # Weak test, must be an OK-packet
            self._connection.unread_result = False
            self._handle_noresultset(result)
        else:
            raise errors.InterfaceError('Invalid result')

    def _execute_iter(self, query_iter):
        """Generator returns MySQLCursor objects for multiple statements

        This method is only used when multiple statements are executed
        by the execute() method. It uses itertools.izip to iterate over the
        given query_iter (result of MySQLConnection.cmd_query_iter()) and
        the list of statements that were executed.

        Yields a MySQLCursor instance.
        """
        if not self._executed_list:
            self._executed_list = RE_SQL_SPLIT_STMTS.split(self._executed)

        for result, stmt in itertools.izip(query_iter,
                                           iter(self._executed_list)):
            self._reset_result()
            self._handle_result(result)
            self._executed = stmt
            yield self

    def execute(self, operation, params=None, multi=False):
        """Executes the given operation

        Executes the given operation substituting any markers with
        the given parameters.

        For example, getting all rows where id is 5:
          cursor.execute("SELECT * FROM t1 WHERE id = %s", (5,))

        The multi argument should be set to True when executing multiple
        statements in one operation. If not set and multiple results are
        found, an InterfaceError will be raised.

        If warnings where generated, and connection.get_warnings is True, then
        self._warnings will be a list containing these warnings.

        Returns an iterator when multi is True, otherwise None.
        """
        if not operation:
            return
        if self._have_unread_result():
            raise errors.InternalError("Unread result found.")

        self._reset_result()
        stmt = ''

        try:
            if isinstance(operation, unicode):
                operation = operation.encode(self._connection.python_charset)
        except (UnicodeDecodeError, UnicodeEncodeError) as err:
            raise errors.ProgrammingError(str(err))

        if params is not None:
            try:
                stmt = operation % self._process_params(params)
            except TypeError:
                raise errors.ProgrammingError(
                    "Wrong number of arguments during string formatting")
        else:
            stmt = operation

        if multi:
            self._executed = stmt
            self._executed_list = []
            return self._execute_iter(self._connection.cmd_query_iter(stmt))
        else:
            self._executed = stmt
            try:
                self._handle_result(self._connection.cmd_query(stmt))
            except errors.InterfaceError:
                if self._connection._have_next_result:  # pylint: disable=W0212
                    raise errors.InterfaceError(
                        "Use multi=True when executing multiple statements")
                raise
            return None

    def executemany(self, operation, seq_params):
        """Execute the given operation multiple times

        The executemany() method will execute the operation iterating
        over the list of parameters in seq_params.

        Example: Inserting 3 new employees and their phone number

        data = [
            ('Jane','555-001'),
            ('Joe', '555-001'),
            ('John', '555-003')
            ]
        stmt = "INSERT INTO employees (name, phone) VALUES ('%s','%s')"
        cursor.executemany(stmt, data)

        INSERT statements are optimized by batching the data, that is
        using the MySQL multiple rows syntax.

        Results are discarded. If they are needed, consider looping over
        data using the execute() method.
        """
        def remove_comments(match):
            """Remove comments from INSERT statements.

            This function is used while removing comments from INSERT
            statements. If the matched string is a comment not enclosed
            by quotes, it returns an empty string, else the string itself.
            """
            if match.group(1):
                return ""
            else:
                return match.group(2)

        if not operation:
            return
        if self._have_unread_result():
            raise errors.InternalError("Unread result found.")
        elif len(RE_SQL_SPLIT_STMTS.split(operation)) > 1:
            raise errors.InternalError(
                "executemany() does not support multiple statements")

        # Optimize INSERTs by batching them
        if re.match(RE_SQL_INSERT_STMT, operation):
            if not seq_params:
                self._rowcount = 0
                return
            tmp = re.sub(RE_SQL_ON_DUPLICATE, '',
                         re.sub(RE_SQL_COMMENT, remove_comments, operation))
            matches = re.search(RE_SQL_INSERT_VALUES, tmp)
            if not matches:
                raise errors.InterfaceError(
                    "Failed rewriting statement for multi-row INSERT. "
                    "Check SQL syntax."
                )
            fmt = matches.group(1)
            values = []
            for params in seq_params:
                values.append(fmt % self._process_params(params))

            if matches.group(1) in operation:
                operation = operation.replace(matches.group(1),
                                              ','.join(values), 1)
                return self.execute(operation)

        rowcnt = 0
        try:
            for params in seq_params:
                self.execute(operation, params)
                if self.with_rows and self._have_unread_result():
                    self.fetchall()
                rowcnt += self._rowcount
        except (ValueError, TypeError) as err:
            raise errors.InterfaceError(
                "Failed executing the operation; %s" % err)
        except:
            # Raise whatever execute() raises
            raise
        self._rowcount = rowcnt

    def stored_results(self):
        """Returns an iterator for stored results

        This method returns an iterator over results which are stored when
        callproc() is called. The iterator will provide MySQLCursorBuffered
        instances.

        Returns a iterator.
        """
        return iter(self._stored_results)

    def callproc(self, procname, args=()):
        """Calls a stored procedue with the given arguments

        The arguments will be set during this session, meaning
        they will be called like  _<procname>__arg<nr> where
        <nr> is an enumeration (+1) of the arguments.

        Coding Example:
          1) Definining the Stored Routine in MySQL:
          CREATE PROCEDURE multiply(IN pFac1 INT, IN pFac2 INT, OUT pProd INT)
          BEGIN
            SET pProd := pFac1 * pFac2;
          END

          2) Executing in Python:
          args = (5,5,0) # 0 is to hold pprod
          cursor.callproc('multiply', args)
          print(cursor.fetchone())

        Does not return a value, but a result set will be
        available when the CALL-statement execute successfully.
        Raises exceptions when something is wrong.
        """
        if not procname or not isinstance(procname, str):
            raise ValueError("procname must be a string")

        if not isinstance(args, (tuple, list)):
            raise ValueError("args must be a sequence")

        argfmt = "@_{name}_arg{index}"
        self._stored_results = []

        results = []
        try:
            argnames = []

            if args:
                for idx, arg in enumerate(args):
                    argname = argfmt.format(name=procname, index=idx + 1)
                    argnames.append(argname)
                    self.execute("SET {0}=%s".format(argname), (arg,))

            call = "CALL {0}({1})".format(procname, ','.join(argnames))

            for result in self._connection.cmd_query_iter(call):
                if 'columns' in result:
                    # pylint: disable=W0212
                    tmp = MySQLCursorBuffered(self._connection._get_self())
                    tmp._handle_result(result)
                    results.append(tmp)
                    # pylint: enable=W0212

            if argnames:
                select = "SELECT {0}".format(','.join(argnames))
                self.execute(select)
                self._stored_results = results
                return self.fetchone()
            else:
                self._stored_results = results
                return ()

        except errors.Error:
            raise
        except StandardError as err:
            raise errors.InterfaceError(
                "Failed calling stored routine; {0}".format(err))

    def getlastrowid(self):
        """Returns the value generated for an AUTO_INCREMENT column

        This method is kept for backward compatibility. Please use the
        property lastrowid instead.

        Returns a long value or None.
        """
        return self.lastrowid

    def _fetch_warnings(self):
        """
        Fetch warnings doing a SHOW WARNINGS. Can be called after getting
        the result.

        Returns a result set or None when there were no warnings.
        """
        res = []
        try:
            cur = self._connection.cursor()
            cur.execute("SHOW WARNINGS")
            res = cur.fetchall()
            cur.close()
        except StandardError as err:
            raise errors.InterfaceError, errors.InterfaceError(
                "Failed getting warnings; %s" % err), sys.exc_info()[2]

        if self._connection.raise_on_warnings is True:
            raise errors.get_mysql_exception(res[0][1], res[0][2])
        else:
            if len(res):
                return res

        return None

    def _handle_eof(self, eof):
        """Handle EOF packet"""
        self._connection.unread_result = False
        self._nextrow = (None, None)
        self._warning_count = eof['warning_count']
        if self._connection.get_warnings is True and eof['warning_count']:
            self._warnings = self._fetch_warnings()

    def _fetch_row(self):
        """Returns the next row in the result set

        Returns a tuple or None.
        """
        if not self._have_unread_result():
            return None
        row = None

        if self._nextrow == (None, None):
            (row, eof) = self._connection.get_row(
                binary=self._binary, columns=self.description)
        else:
            (row, eof) = self._nextrow

        if row:
            self._nextrow = self._connection.get_row(
                binary=self._binary, columns=self.description)
            eof = self._nextrow[1]
            if eof is not None:
                self._handle_eof(eof)
            if self._rowcount == -1:
                self._rowcount = 1
            else:
                self._rowcount += 1
        if eof:
            self._handle_eof(eof)

        return row

    def fetchwarnings(self):
        """Returns warnings"""
        return self._warnings

    def fetchone(self):
        """Returns next row of a query result set

        Returns a tuple or None.
        """
        row = self._fetch_row()
        if row:
            return self._row_to_python(row)
        return None

    def fetchmany(self, size=None):
        res = []
        cnt = (size or self.arraysize)
        while cnt > 0 and self._have_unread_result():
            cnt -= 1
            row = self.fetchone()
            if row:
                res.append(row)
        return res

    def fetchall(self):
        if not self._have_unread_result():
            raise errors.InterfaceError("No result set to fetch from.")
        (rows, eof) = self._connection.get_rows()
        if self._nextrow[0]:
            rows.insert(0, self._nextrow[0])
        res = [self._row_to_python(row) for row in rows]
        self._handle_eof(eof)
        rowcount = len(rows)
        if rowcount >= 0 and self._rowcount == -1:
            self._rowcount = 0
        self._rowcount += rowcount
        return res

    @property
    def column_names(self):
        """Returns column names

        This property returns the columns names as a tuple.

        Returns a tuple.
        """
        if not self.description:
            return ()
        return tuple([d[0].decode('utf8') for d in self.description])

    @property
    def statement(self):
        """Returns the executed statement

        This property returns the executed statement. When multiple
        statements were executed, the current statement in the iterator
        will be returned.
        """
        return self._executed.strip()

    @property
    def with_rows(self):
        """Returns whether the cursor could have rows returned

        This property returns True when column descriptions are available
        and possibly also rows, which will need to be fetched.

        Returns True or False.
        """
        if not self.description:
            return False
        return True

    def __unicode__(self):
        fmt = "MySQLCursor: %s"
        if self._executed:
            if len(self._executed) > 30:
                res = fmt % (self._executed[:30] + '..')
            else:
                res = fmt % (self._executed)
        else:
            res = fmt % '(Nothing executed yet)'
        return res

    def __str__(self):
        return repr(self.__unicode__())


class MySQLCursorBuffered(MySQLCursor):
    """Cursor which fetches rows within execute()"""

    def __init__(self, connection=None):
        MySQLCursor.__init__(self, connection)
        self._rows = None
        self._next_row = 0

    def _handle_resultset(self):
        (self._rows, eof) = self._connection.get_rows()
        self._rowcount = len(self._rows)
        self._handle_eof(eof)
        self._next_row = 0
        try:
            self._connection.unread_result = False
        except:
            pass

    def reset(self):
        self._rows = None

    def _fetch_row(self):
        """Returns the next row in the result set

        Returns a tuple or None.
        """
        row = None
        try:
            row = self._rows[self._next_row]
        except:
            return None
        else:
            self._next_row += 1
            return row
        return None

    def fetchall(self):
        if self._rows is None:
            raise errors.InterfaceError("No result set to fetch from.")
        res = []
        for row in self._rows[self._next_row:]:
            res.append(self._row_to_python(row))
        self._next_row = len(self._rows)
        return res

    def fetchmany(self, size=None):
        res = []
        cnt = (size or self.arraysize)
        while cnt > 0:
            cnt -= 1
            row = self.fetchone()
            if row:
                res.append(row)

        return res

    @property
    def with_rows(self):
        return self._rows is not None


class MySQLCursorRaw(MySQLCursor):
    """
    Skips conversion from MySQL datatypes to Python types when fetching rows.
    """
    def fetchone(self):
        row = self._fetch_row()
        if row:
            return row
        return None

    def fetchall(self):
        if not self._have_unread_result():
            raise errors.InterfaceError("No result set to fetch from.")
        (rows, eof) = self._connection.get_rows()
        if self._nextrow[0]:
            rows.insert(0, self._nextrow[0])
        self._handle_eof(eof)
        rowcount = len(rows)
        if rowcount >= 0 and self._rowcount == -1:
            self._rowcount = 0
        self._rowcount += rowcount
        return rows


class MySQLCursorBufferedRaw(MySQLCursorBuffered):
    """
    Cursor which skips conversion from MySQL datatypes to Python types when
    fetching rows and fetches rows within execute().
    """
    def fetchone(self):
        row = self._fetch_row()
        if row:
            return row
        return None

    def fetchall(self):
        if self._rows is None:
            raise errors.InterfaceError("No result set to fetch from.")
        return self._rows[self._next_row:]


class MySQLCursorPrepared(MySQLCursor):
    """Cursor using MySQL Prepared Statements
    """
    def __init__(self, connection=None):
        super(MySQLCursorPrepared, self).__init__(connection)
        self._rows = None
        self._next_row = 0
        self._prepared = None
        self._binary = True
        self._have_result = None

    def callproc(self, *args, **kwargs):
        """Calls a stored procedure

        Not supported with MySQLCursorPrepared.
        """
        raise errors.NotSupportedError()

    def close(self):
        """Close the cursor

        This method will try to deallocate the prepared statement and close
        the cursor.
        """
        if self._prepared:
            try:
                self._connection.cmd_stmt_close(self._prepared['statement_id'])
            except errors.Error:
                # We tried to deallocate, but it's OK when we fail.
                pass
            self._prepared = None
        super(MySQLCursorPrepared, self).close()

    def _row_to_python(self, rowdata, desc=None):
        """Convert row data from MySQL to Python types

        The conversion is done while reading binary data in the
        protocol module.
        """
        pass

    def _handle_result(self, res):
        """Handle result after execution"""
        if isinstance(res, dict):
            self._connection.unread_result = False
            self._have_result = False
            self._handle_noresultset(res)
        else:
            self._description = res[1]
            self._connection.unread_result = True
            self._have_result = True

    def execute(self, operation, params=(), multi=False):
        """Prepare and execute a MySQL Prepared Statement

        This method will prepare the given operation and execute it using
        the optionally given parameters.

        If the cursor instance already had a prepared statement, it is
        first closed.
        """
        if operation is not self._executed:
            if self._prepared:
                self._connection.cmd_stmt_close(self._prepared['statement_id'])

            self._executed = operation
            # need to convert %s to ? before sending it to MySQL
            if '%s' in operation:
                operation = re.sub(RE_SQL_FIND_PARAM, '?', operation)

            try:
                self._prepared = self._connection.cmd_stmt_prepare(operation)
            except errors.Error:
                self._executed = None
                raise

        self._connection.cmd_stmt_reset(self._prepared['statement_id'])

        if self._prepared['parameters'] and not params:
            return
        elif len(self._prepared['parameters']) != len(params):
            raise errors.ProgrammingError(
                errno=1210,
                msg="Incorrect number of arguments "
                    "executing prepared statement")

        res = self._connection.cmd_stmt_execute(
            self._prepared['statement_id'],
            data=params,
            parameters=self._prepared['parameters'])
        self._handle_result(res)

    def executemany(self, operation, seq_params):
        """Prepare and execute a MySQL Prepared Statement many times

        This method will prepare the given operation and execute with each
        tuple found the list seq_params.

        If the cursor instance already had a prepared statement, it is
        first closed.

        executemany() simply calls execute().
        """
        rowcnt = 0
        try:
            for params in seq_params:
                self.execute(operation, params)
                if self.with_rows and self._have_unread_result():
                    self.fetchall()
                rowcnt += self._rowcount
        except (ValueError, TypeError) as err:
            raise errors.InterfaceError(
                "Failed executing the operation; {error}".format(error=err))
        except:
            # Raise whatever execute() raises
            raise
        self._rowcount = rowcnt

    def fetchone(self):
        """Returns next row of a query result set

        Returns a tuple or None.
        """
        return self._fetch_row() or None

    def fetchmany(self, size=None):
        res = []
        cnt = (size or self.arraysize)
        while cnt > 0 and self._have_unread_result():
            cnt -= 1
            row = self._fetch_row()
            if row:
                res.append(row)
        return res

    def fetchall(self):
        if not self._have_unread_result():
            raise errors.InterfaceError("No result set to fetch from.")
        (rows, eof) = self._connection.get_rows(
            binary=self._binary, columns=self.description)
        self._rowcount = len(rows)
        self._handle_eof(eof)
        return rows
