#!/usr/bin/env python

import ConfigParser
config = ConfigParser.ConfigParser()
config.read("/home/pi/.reicast/emu.cfg")

ps3ControlNamesToConfigureForDreamcast=['PLAYSTATION(R)3 Controller',
                                        'Sony PLAYSTATION(R)3 Controller',
                                        'Sony Computer Entertainment Wireless Controller']

for section in config.sections():
    print "Section: [%s]" % section
    for name in ps3ControlNamesToConfigureForDreamcast:
        if section == name:
            print "[%s] PS3 controller config section discovered!" % (name)
    for options in config.options(section):
        print "%s = %s" % (options, config.get(section, options))
