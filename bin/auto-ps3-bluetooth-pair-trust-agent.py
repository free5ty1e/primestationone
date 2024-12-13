#!/usr/bin/env python3
# SPDX-License-Identifier: LGPL-2.1-or-later

from __future__ import absolute_import, print_function, unicode_literals

from optparse import OptionParser
import sys
import dbus
import dbus.service
import dbus.mainloop.glib
try:
  from gi.repository import GObject
except ImportError:
  import gobject as GObject
import bluezutils

BUS_NAME = 'org.bluez'
AGENT_INTERFACE = 'org.bluez.Agent1'
AGENT_PATH = "/test/agent"

bus = None
device_obj = None
dev_path = None

# Define the PS4 Controller's Bluetooth MAC address pattern (you can adapt this to your setup)
# PS4_CONTROLLER_MAC_PREFIX = "23:07:6A"  # Example prefix, modify as necessary
# Device 48:18:8D:B2:CE:EE Wireless Controller - blue ps4 chewed controller
# Device 23:07:6A:50:0F:AC Wireless Controller - black generic ps4 controller 1

def ask(prompt):
	try:
		return raw_input(prompt)
	except:
		return input(prompt)

def set_trusted(device_path):
    print(f"Trusting device at {device_path}")
    bus = dbus.SystemBus()
    bluez = bus.get_object('org.freedesktop.DBus', '/org/bluez')
    adapter = dbus.Interface(bluez, 'org.freedesktop.DBus.Properties')
    adapter.Set('org.freedesktop.DBus.Properties', 'Trusted', dbus.Boolean(True))

def pair_device(device_path):
    print(f"Pairing with device at {device_path}")
    device = dbus.SystemBus().get_object('org.bluez', device_path)
    device.Pair(dbus.Boolean(True))

def connect_device(device_path):
    print(f"Connecting to device at {device_path}")
    device = dbus.SystemBus().get_object('org.bluez', device_path)
    device.Connect(dbus.Boolean(True))

# Main function where devices are found
def process_device(device_path):
    print(f"Device found at {device_path}")
    set_trusted(device_path)
    pair_device(device_path)
    connect_device(device_path)

def dev_connect(path):
	dev = dbus.Interface(bus.get_object("org.bluez", path),
							"org.bluez.Device1")
	dev.Connect()

class Rejected(dbus.DBusException):
	_dbus_error_name = "org.bluez.Error.Rejected"

class Agent(dbus.service.Object):
	exit_on_release = True

	def set_exit_on_release(self, exit_on_release):
		self.exit_on_release = exit_on_release

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="", out_signature="")
	def Release(self):
		print("Release")
		if self.exit_on_release:
			mainloop.quit()

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="os", out_signature="")
	def AuthorizeService(self, device, uuid):
		print("AuthorizeService (%s, %s)" % (device, uuid))
		# authorize = ask("Authorize connection (yes/no): ")
		# if (authorize == "yes"):
		return
		# raise Rejected("Connection rejected by user")

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="o", out_signature="s")
	def RequestPinCode(self, device):
		print("RequestPinCode (%s)" % (device))
		set_trusted(device)
		# dev_connect(device)
		return "0000\n" #dbus.UInt32(0000) 
		#return ask("Enter PIN Code: ")

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="o", out_signature="u")
	def RequestPasskey(self, device):
		print("RequestPasskey (%s)" % (device))
		set_trusted(device)
		# passkey = ask("Enter passkey: ")
		# return dbus.UInt32(passkey)
		return dbus.UInt32(0000) #hard code PIN to 0000

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="ouq", out_signature="")
	def DisplayPasskey(self, device, passkey, entered):
		print("DisplayPasskey (%s, %06u entered %u)" %
						(device, passkey, entered))

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="os", out_signature="")
	def DisplayPinCode(self, device, pincode):
		print("DisplayPinCode (%s, %s)" % (device, pincode))

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="ou", out_signature="")
	def RequestConfirmation(self, device, passkey):
		print("RequestConfirmation (%s, %06d)" % (device, passkey))
		# confirm = ask("Confirm passkey (yes/no): ")
		# if (confirm == "yes"):
		set_trusted(device)
		return
		# raise Rejected("Passkey doesn't match")

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="o", out_signature="")
	def RequestAuthorization(self, device):
		print("RequestAuthorization (%s)" % (device))
		# auth = ask("Authorize? (yes/no): ")
		# if (auth == "yes"):
		return
		# raise Rejected("Pairing rejected")

	@dbus.service.method(AGENT_INTERFACE,
					in_signature="", out_signature="")
	def Cancel(self):
		print("Cancel")

def pair_reply():
	print("Device paired")
	set_trusted(dev_path)
	dev_connect(dev_path)
	mainloop.quit()

def pair_error(error):
	err_name = error.get_dbus_name()
	if err_name == "org.freedesktop.DBus.Error.NoReply" and device_obj:
		print("Timed out. Cancelling pairing")
		device_obj.CancelPairing()
	else:
		print("Creating device failed: %s" % (error))
	mainloop.quit()

# def on_device_found(address, name):
#     print(f"Device found: {name} ({address})")
    
#     # Check if the device is a PS4 controller (based on address or name)
#     if address.startswith(PS4_CONTROLLER_MAC_PREFIX):  # or you can check by name
#         print(f"PS4 controller found, auto trusting...")
#         # Automatically trust the device
#         set_trusted(f"/org/bluez/hci0/dev_{address.replace(':', '_')}")
#         dev_connect(f"/org/bluez/hci0/dev_{address.replace(':', '_')}")

def on_device_found(interface, changed, invalidated, path=None):
    print(f"on_device_found(interface={interface},\nchanged={changed},\npath={path})")

    # Look for relevant device properties in the changed dictionary
    if "Connected" in changed and changed["Connected"] is True:
        # Device connected; proceed to check its identity
        device_path = path
        try:
            # Retrieve the device object
            device = dbus.SystemBus().get_object("org.bluez", device_path)
            props = dbus.Interface(device, "org.freedesktop.DBus.Properties")

            # Check for "Name" or other identifying properties
            name = props.Get("org.bluez.Device1", "Name")
            address = props.Get("org.bluez.Device1", "Address")

            print(f"Device connected: Name={name}, Address={address}")

            # Verify if it's the PS4 controller
            if "Wireless Controller" in name:
                print(f"PS4 controller detected. Proceeding to auto trust, pair, and connect.")
                process_device(device_path)
            else:
                print("Connected device is not a PS4 controller.")
        except dbus.DBusException as e:
            print(f"Error retrieving device properties: {e}")

if __name__ == '__main__':
	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

	bus = dbus.SystemBus()

	capability = "NoInputNoOutput"

	parser = OptionParser()
	parser.add_option("-i", "--adapter", action="store",
					type="string",
					dest="adapter_pattern",
					default=None)
	parser.add_option("-c", "--capability", action="store",
					type="string", dest="capability")
	parser.add_option("-t", "--timeout", action="store",
					type="int", dest="timeout",
					default=60000)
	(options, args) = parser.parse_args()
	if options.capability:
		capability  = options.capability

	path = "/test/agent"
	agent = Agent(bus, path)

	mainloop = GObject.MainLoop()

	obj = bus.get_object(BUS_NAME, "/org/bluez");
	manager = dbus.Interface(obj, "org.bluez.AgentManager1")
	manager.RegisterAgent(path, capability)

	print("Agent registered")

    # Register callback to detect devices
	obj = bus.get_object("org.freedesktop.DBus", "/org/freedesktop/dbus")
	interface = dbus.Interface(obj, "org.freedesktop.DBus.Properties")
    
    # Listen for device discovery events
	bus.add_signal_receiver(on_device_found, 
							dbus_interface="org.freedesktop.DBus.Properties", 
							signal_name="PropertiesChanged", 
							path_keyword="path")

	# Fix-up old style invocation (BlueZ 4)
	if len(args) > 0 and args[0].startswith("hci"):
		options.adapter_pattern = args[0]
		del args[:1]

	if len(args) > 0:
		device = bluezutils.find_device(args[0],
						options.adapter_pattern)
		dev_path = device.object_path
		agent.set_exit_on_release(False)
		device.Pair(reply_handler=pair_reply, error_handler=pair_error,
								timeout=60000)
		device_obj = device
	else:
		manager.RequestDefaultAgent(path)

	mainloop.run()

	#adapter.UnregisterAgent(path)
	#print("Agent unregistered")
