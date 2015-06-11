#!/usr/bin/env python

import ConfigParser
config = ConfigParser.ConfigParser()
config.read("/home/pi/.reicast/emu.cfg")

ps3ControlNamesToConfigureForDreamcast=['PLAYSTATION(R)3 Controller',
                                        'Sony PLAYSTATION(R)3 Controller',
                                        'Sony Computer Entertainment Wireless Controller']

def set_ps3_controls_for_section(section_name)
    config.set(section_name, "button.0", "Btn_Z")
    config.set(section_name, "button.1", "Btn_C")
    config.set(section_name, "button.2", "Btn_D")
    config.set(section_name, "button.3", "Btn_Start")
    config.set(section_name, "button.4", "DPad_Up")
    config.set(section_name, "button.5", "DPad_Right")
    config.set(section_name, "button.6", "DPad_Down")
    config.set(section_name, "button.7", "DPad_Left")
    config.set(section_name, "button.8", "Axis_LT")
    config.set(section_name, "button.9", "Axis_RT")
    config.set(section_name, "button.10", "DPad2_Left")
    config.set(section_name, "button.11", "DPad2_Right")
    config.set(section_name, "button.12", "Btn_Y")
    config.set(section_name, "button.13", "Btn_B")
    config.set(section_name, "button.14", "Btn_A")
    config.set(section_name, "button.15", "Btn_X")
    config.set(section_name, "button.16", "Quit")
    config.set(section_name, "axis.0", "Axis_X")
    config.set(section_name, "axis.1", "Axis_Y")
    config.set(section_name, "axis.2", "DPad2_Up")
    config.set(section_name, "axis.3", "DPad2_Down")
    config.set(section_name, "axis.4", "DPad2_Left")
    config.set(section_name, "axis.5", "DPad2_Right")

ps3ControllersAlreadyDefined=[]

for section in config.sections():
    print "Section: [%s]" % section
    for name in ps3ControlNamesToConfigureForDreamcast:
        if section == name:
            print "[%s] Existing PS3 controller config section discovered!" % name
            ps3ControllersAlreadyDefined.append(name)
            for option in config.options(section):
                print "%s = %s" % (option, config.get(section, option))


for name in ps3ControlNamesToConfigureForDreamcast:
    if name not in ps3ControllersAlreadyDefined:
        config.add_section(name)
    set_ps3_controls_for_section(name)

