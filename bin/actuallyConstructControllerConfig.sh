#!/bin/bash
echo Constructing the controller configs en masse to ALL match the splashscreen quick reference image...
echo This will also enable non-PS3 controllers to map closely to the splashscreen instead of being way off...

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"

md_build="/home/pi/temp/joypadautoconfig"
emudir="/opt/retropie/emulators"

function remap_hotkeys_retroarchautoconf() {
    local file="$1"
    local ini_value
    local input_exit_emu="input_start"

    [[ -z "$file" || ! -f "$file" ]] && return 1


    printMsgs "console" "Processing $file"

    iniGet "input_device" "$file"
    if [[ $ini_value == *"PLAYSTATION(R)3"* ]] 
    then
        echo Controller with PS button detected!  Inserting missing PS button mapping...
        iniSet "input_ps_btn" "16" "$file" >/dev/null
	input_exit_emu="input_ps"
    fi

    iniConfig " = " "\""
    local mappings=(
        'input_enable_hotkey input_select'
        'input_exit_emulator '$input_exit_emu
        'input_menu_toggle input_l'
        'input_load_state input_b'
        'input_save_state input_y'
        'input_reset input_up'
        'input_state_slot_increase input_r'
        'input_state_slot_decrease input_r2'
        'input_disk_eject_toggle input_left'
        'input_disk_prev input_l_x_minus'
        'input_disk_next input_l_x_plus'
        'input_analog_dpad_mode input_down'
        'input_movie_record_toggle input_r3'
        'input_screenshot input_l3'
        'input_rewind input_r_x_minus'
        'input_hold_fast_forward input_r_x_plus'
        'input_toggle_fast_forward input_a'
        'input_pause_toggle input_start'
        'input_frame_advance input_x'
        'input_slowmotion input_r_y_plus'
        'input_netplay_flip_players input_l2'
        'input_volume_up input_l_y_minus'
        'input_volume_down input_l_y_plus'
        'input_turbo input_r_y_minus'
    )

    for mapping in "${mappings[@]}"; do
        mapping=($mapping)
        for suffix in axis btn; do
            iniGet "${mapping[1]}_${suffix}" "$file"
            if [[ -n "$ini_value" ]]; then
                iniSet "${mapping[0]}_${suffix}" "$ini_value" "$file" >/dev/null
            fi
        done
    done
}

echo Cloning latest updated retroarch joypad base autoconfigs...
gitPullOrClone "$md_build" https://github.com/libretro/retroarch-joypad-autoconfig

echo Checking to ensure clone was successful before proceeding....
if [ -d "$md_build/udev" ]; then

    echo Mapping any non-libretrocore emulators that we know how...
    n64SetupPs3Controls.sh

    echo Wiping out any existing controller autoconfigs
    sudo rm -rf "$emudir/retroarch/configs"

    echo Installing retroarch joypad base autoconfigs...
    sudo mkdir -p "$emudir/retroarch/configs/"

    echo Stripping CRs from the autoconfigs....
    cd "$md_build/udev/"
    for file in *; do
        sudo tr -d '\015' <"$file" >"$emudir/retroarch/configs/$file"
        sudo chown $user:$user "$emudir/retroarch/configs/$file"
    done

    echo Mapping special functions to match Primestation splashscreen...
    printMsgs "console" "Remapping controller hotkeys"

    for file in "$emudir/retroarch/configs/"*; do
        remap_hotkeys_retroarchautoconf "$file"
    done

    echo "Applying Workaround for PS4 controller overriding PS3 controllers on some newer bluetooth adapters, both show up as Sony Computer Entertainment Wireless Controller so Im erring on the side of I want PS3 controllers to work on the Primestation One..."
    rm -v /opt/retropie/emulators/retroarch/configs/Sony_Computer_Entertainment_Wireless_Controller.cfg
    cp -v /opt/retropie/emulators/retroarch/configs/PS3Controller.cfg /opt/retropie/emulators/retroarch/configs/Sony_Computer_Entertainment_Wireless_Controller.cfg
    iniSet "input_device" "Sony Computer Entertainment Wireless Controller" "/opt/retropie/emulators/retroarch/configs/Sony_Computer_Entertainment_Wireless_Controller.cfg" >/dev/null


    echo Remapping individual emulator buttons to be more sensible and use Square for B instead of Cross for B which is asinine...
    #local
    #above keyword only for when below is in its own function:
    emulatorsToButtonSwap=(
        'nes'
        'gb'
        'gbc'
        'gba'
        'n64'
        'pcengine'
    )

    for emu in "${emulatorsToButtonSwap[@]}"; do
        emu=($emu)
        iniConfig " = " "" "/opt/retropie/configs/$emu/retroarch.cfg"
        iniSet "input_player1_y_btn" "13"
        iniSet "input_player1_a_btn" "14"
        iniSet "input_player1_b_btn" "15"
        iniSet "input_player2_y_btn" "13"
        iniSet "input_player2_a_btn" "14"
        iniSet "input_player2_b_btn" "15"
        iniSet "input_player3_y_btn" "13"
        iniSet "input_player3_a_btn" "14"
        iniSet "input_player3_b_btn" "15"
        iniSet "input_player4_y_btn" "13"
        iniSet "input_player4_a_btn" "14"
        iniSet "input_player4_b_btn" "15"
    done

    echo Remapping more individual emulator buttons to be more sensible and use Square for attack instead of Cross which is asinine...
    #local
    #above keyword only for when below is in its own function:
    emulatorsToButtonSwapReverse=(
        'gamegear'
        'mastersystem'
        'sg-1000'
    )

    for emu in "${emulatorsToButtonSwapReverse[@]}"; do
        emu=($emu)
        iniConfig " = " "" "/opt/retropie/configs/$emu/retroarch.cfg"
        iniSet "input_player1_y_btn" "13"
        iniSet "input_player1_a_btn" "15"
        iniSet "input_player1_b_btn" "14"
        iniSet "input_player2_y_btn" "13"
        iniSet "input_player2_a_btn" "15"
        iniSet "input_player2_b_btn" "14"
        iniSet "input_player3_y_btn" "13"
        iniSet "input_player3_a_btn" "15"
        iniSet "input_player3_b_btn" "14"
        iniSet "input_player4_y_btn" "13"
        iniSet "input_player4_a_btn" "15"
        iniSet "input_player4_b_btn" "14"
    done


    echo Rearranging horribly wrong emulator button mappings for MAME to be more generally usable...
    #local
    #above keyword only for when below is in its own function:
    emulatorsToRearrangeButtons=(
        'mame-mame4all'
    )

    for emu in "${emulatorsToRearrangeButtons[@]}"; do
        emu=($emu)
        iniConfig " = " "" "/opt/retropie/configs/$emu/retroarch.cfg"

#Libretrocore Mame4all internal retroarch mappings to take into consideration for a generic mame4all ps3 map:
#SF2 L punch = b_btn
#SF2 M punch = a_btn
#SF2 H punch = y_btn
#SF2 L kick =  x_btn
#SF2 M kick =  l_btn
#SF2 H kick =  r_btn

#MK2 L punch = x_btn
#MK2 H punch = a_btn
#MK2 Block = y_btn
#MK2 L kick = l_btn
#MK2 H kick = b_btn

#ForgottenWorlds rotateCCW l_btn
#ForgottenWorlds rotateCW r_btn

#GenericGame Fire b_btn
#GenericGame Jump a_btn
#insert coin -> L3 instead of Select to avoid conflicts in some games
        iniSet "input_player1_select_btn" "1"
        iniSet "input_player1_l_btn" "10"
        iniSet "input_player1_r_btn" "11"
        iniSet "input_player1_x_btn" "12"
        iniSet "input_player1_y_btn" "13"
        iniSet "input_player1_a_btn" "14"
        iniSet "input_player1_b_btn" "15"

        iniSet "input_player2_select_btn" "1"
        iniSet "input_player2_l_btn" "10"
        iniSet "input_player2_r_btn" "11"
        iniSet "input_player2_x_btn" "12"
        iniSet "input_player2_y_btn" "13"
        iniSet "input_player2_a_btn" "14"
        iniSet "input_player2_b_btn" "15"

        iniSet "input_player3_select_btn" "1"
        iniSet "input_player3_l_btn" "10"
        iniSet "input_player3_r_btn" "11"
        iniSet "input_player3_x_btn" "12"
        iniSet "input_player3_y_btn" "13"
        iniSet "input_player3_a_btn" "14"
        iniSet "input_player3_b_btn" "15"

        iniSet "input_player4_select_btn" "1"
        iniSet "input_player4_l_btn" "10"
        iniSet "input_player4_r_btn" "11"
        iniSet "input_player4_x_btn" "12"
        iniSet "input_player4_y_btn" "13"
        iniSet "input_player4_a_btn" "14"
        iniSet "input_player4_b_btn" "15"

    done

    echo Configuring Dreamcast Reicast PS3 controls...
    python /home/pi/primestationone/bin/dreamcastMapPs3ControlsForReicast.py

    echo "Adding configs to support newer (2015+) ShanWan generic PS3 controllers too..."
    sudo cp -v /opt/retropie/emulators/retroarch/configs/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg /opt/retropie/emulators/retroarch/configs/ShanWanPS3Gamepad.cfg
    iniSet "input_device" "ShanWan PS(R) Ga`epad" "/opt/retropie/emulators/retroarch/configs/ShanWanPS3Gamepad.cfg" >/dev/null

    sudo cp -v /opt/retropie/emulators/retroarch/configs/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg /opt/retropie/emulators/retroarch/configs/ShanWanPS3Gamepad2.cfg
    iniSet "input_device" "ShanWan PS(R) Gamepad" "/opt/retropie/emulators/retroarch/configs/ShanWanPS3Gamepad2.cfg" >/dev/null

else
    echo Clone unsuccessful!  Unable to proceed with joypad autoconfig update....
fi



#pushd ~
#mkdir temp
#cd temp
#for file in ~/primestationone/reference/opt/retropie/emulators/retroarch/configs/*.header.cfg; do
#    filename=$(basename "$file")
#    cfgextension="${filename##*.}"
#    headerfilename="${filename%.*}"
#    filename="${headerfilename%.*}"
#    cat "$file" > "$filename.cfg"
#    cat ~/primestationone/reference/opt/retropie/emulators/retroarch/configs/PS3Controller.master.cfg >> "$filename.cfg"
#    echo "Constructed new controller config file: $filename.cfg with contents: "
#    cat "$filename.cfg"
#done
#echo Installing constructed controller configs to RetroArch autoconfig folder...
#sudo cp -vr ~/temp/*.cfg /opt/retropie/emulators/retroarch/configs/
#rm ~/temp/*.cfg
#popd
