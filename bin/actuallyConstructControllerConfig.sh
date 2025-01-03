#!/bin/bash

echo "Constructing the controller configs en masse to ALL match the splashscreen quick reference image..."
echo "This will also enable non-PS3 controllers to map closely to the splashscreen instead of being way off..."

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"

md_build="/home/pi/temp/joypadautoconfig"
retropiebase="/opt/retropie"
emudir="$retropiebase/emulators"
configdir="$emudir/retroarch/configs"
legacyconfigsdir="$configdir"
newretropieconfigsdir="$retropiebase/configs"
allconfigsdir="/home/pi/.config/retroarch/autoconfig"

configdirs=(
    # "$legacyconfigsdir"
    "$allconfigsdir"
)

emuconfigdirs=(
    # "$legacyconfigsdir"
    "$newretropieconfigsdir"
)

function remap_hotkeys_retroarchautoconf() {
    local file="$1"
    local ini_value
    # local input_exit_emu="input_start"

    [[ -z "$file" || ! -f "$file" ]] && return 1


    # printMsgs "console" "Processing $file"
    echo "Remapping hotkeys for joystick: $file"

    iniGet "input_device" "$file"
    if [[ $ini_value == *"X-Box"* || $ini_value == *"Xbox"* ]]
    then
        echo "This is an xbox 360 controller, Inserting missing Guide button mapping..."
        iniSet "input_mode_btn" "8" "$file" >/dev/null
    elif [[ $ini_value == *"PLAYSTATION"* || $ini_value == *"Playstation"* || $ini_value == *"Sony"* || $ini_value == *"ShanWan"* || $ini_value == *"Gasia"* ]]
    then 
        echo "Controller with PS button detected!  Inserting missing PS button mapping..."
        iniSet "input_mode_btn" "10" "$file" >/dev/null
    fi

    iniConfig " = " "\""
    local mappings=(
        'input_enable_hotkey input_mode'
        'input_exit_emulator input_select'
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

#PARAMETER 1: SKIP_CONTROLLER_REPO_MODS optionally skip the controller repo mod stage since it is slow.  Can be any word.
if [ -z "$1" ]; then
    echo "parameter 1: SKIP_CONTROLLER_REPO_MODS is optional!  Will run controller repo mods..."

    echo "Cloning latest updated retroarch joypad base autoconfigs..."
    # gitPullOrClone "$md_build" https://github.com/libretro/retroarch-joypad-autoconfig
    sudo /home/pi/RetroPie-Setup/retropie_packages.sh retroarch update_joypad_autoconfigs

    echo "Correcting probably incorrect controller autoconfig location"
    # ls -lha /opt/retropie/configs/all
    # ls -lha /opt/retropie/configs/all/retroarch-joypads
    # sudo rm /opt/retropie/configs/all/retroarch-joypads
    # sudo ln -s /opt/retropie/emulators/retroarch/autoconfig-presets /opt/retropie/configs/all/retroarch-joypads
    # ls -lha /opt/retropie/configs/all
    # ls -lha /opt/retropie/configs/all/retroarch-joypads
    cp -vr /opt/retropie/emulators/retroarch/autoconfig-presets/* $allconfigsdir/

    esControllerAutoConfig.sh

    echo "Checking to ensure clone was successful before proceeding...."
    if [ -d "$allconfigsdir/udev" ]; then

    #    echo Wiping out any existing controller autoconfigs
    #    sudo rm -rf "$configdir"

        for whichconfigdir in "${configdirs[@]}"; do
            if [ -d "$whichconfigdir" ]; then
                echo "Installing retroarch joypad base autoconfigs and legacy autoconfigs..."
                # sudo mkdir -p "$whichconfigdir/"
                
                echo "Stripping CRs from the autoconfigs...."
                cd "$whichconfigdir/udev/"
                for file in *; do
                    sudo tr -d '\015' <"$file" >"$whichconfigdir/$file"
                    sudo chown $user:$user "$whichconfigdir/$file"
                done

                echo "Mapping special functions to match Primestation splashscreen..."
                printMsgs "console" "Remapping controller hotkeys"

                find "$whichconfigdir/" -print0 | while read -d $'\0' file
                    do
                        remap_hotkeys_retroarchautoconf "$file"
                    done

                # echo "Applying Workaround for PS4 controller overriding PS3 controllers on some newer bluetooth adapters, both show up as Sony Computer Entertainment Wireless Controller so Im erring on the side of I want PS3 controllers to work on the Primestation One..."
                # rm -v "$whichconfigdir/Sony_Computer_Entertainment_Wireless_Controller.cfg"
                # cp -v "$whichconfigdir/PS3Controller.cfg" "$whichconfigdir/Sony_Computer_Entertainment_Wireless_Controller.cfg"
                # iniSet "input_device" "Sony Computer Entertainment Wireless Controller" "$whichconfigdir/Sony_Computer_Entertainment_Wireless_Controller.cfg" >/dev/null

                # echo "Adding configs to support other various known generic PS3 controllers too..."
                # echo "TODO: Refactor the below into a function instead of duplicating this code repeatedly..."
                # sudo cp -v "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg" "$whichconfigdir/ShanWanPS3Gamepad.cfg"
                # iniSet "input_device" "ShanWan PS\(R\) Ga\`epad" "$whichconfigdir/ShanWanPS3Gamepad.cfg" >/dev/null

                # sudo cp -v "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg" "$whichconfigdir/ShanWanPS3Gamepad2.cfg"
                # iniSet "input_device" "ShanWan PS\(R\) Gamepad" "$whichconfigdir/ShanWanPS3Gamepad2.cfg" >/dev/null

                # sudo cp -v "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg" "$whichconfigdir/SzmyNoSixaxisPS3Gamepad.cfg"
                # iniSet "input_device" "SZMY-POWER CO.,LTD. PLAYSTATION(R)3 Controller" "$whichconfigdir/SzmyNoSixaxisPS3Gamepad.cfg" >/dev/null

            else
                echo "$whichconfigdir does not exist, skipping!"
            fi
        done
        # echo "Now removing problematic confusing configurations that interfere with the PS3 controller sometimes setting up correctly..."
        # sudo rm --verbose --force "$whichconfigdir/Gasia_PS_Gamepad_USB.cfg"
        # rm "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluez.cfg"
        # sudo rm --verbose --force "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg"
        # sudo rm --verbose --force "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluetooth.cfg.bak"
        # sudo rm --verbose --force "$whichconfigdir/Sony-PlayStation3-DualShock3-Controller-Bluez.cfg"
    else
        echo "Clone unsuccessful!  Unable to proceed with joypad autoconfig update...."
    fi   
fi

echo "Mapping any non-libretrocore emulators that we know how..."
n64SetupPs3Controls.sh
dosSetupPs3Controls.sh

for whichemuconfigdir in "${emuconfigdirs[@]}"; do
    if [ -d "$whichemuconfigdir" ]; then
        echo "Clearing remapping individual emulator buttons to be more sensible and use Square for B instead of Cross for B which is asinine..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToButtonSwap=(
            'nes'
            'gb'
            'gbc'
            'gba'
            # 'n64'
            'pcengine'
            'supergrafx'
            'mame2000'
            'mame2003'
            'mame2010'
            'mame2015'
            'mame2016'
        )

        #Old mapping was 12triangle, 13circle, 14x, 15square
        #New mapping is 0x, 1circle, 2triangle, 3square
        #Before, we were setting Jump (a) to the Cross button (14)
        #   and Fire (b) to the Square (15) button instead of Circle (13) which is the default
        #   and then Aux (y) to the Circle (13) button instead of the Square (15) button which is the default
        #   ...heretofore: we want to set y to 1, a to 0, and b to 3

        for emu in "${emulatorsToButtonSwap[@]}"; do
            emu=($emu)
            iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
            iniUnset "input_player1_y_btn" "1"
            iniUnset "input_player1_a_btn" "0"
            iniUnset "input_player1_b_btn" "3"
            iniUnset "input_player2_y_btn" "1"
            iniUnset "input_player2_a_btn" "0"
            iniUnset "input_player2_b_btn" "3"
            iniUnset "input_player3_y_btn" "1"
            iniUnset "input_player3_a_btn" "0"
            iniUnset "input_player3_b_btn" "3"
            iniUnset "input_player4_y_btn" "1"
            iniUnset "input_player4_a_btn" "0"
            iniUnset "input_player4_b_btn" "3"
        done

        echo "Clearing remaps for more individual emulator buttons to be more sensible and use Square for attack instead of Cross which is asinine..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToButtonSwapReverse=(
            'gamegear'
            'mastersystem'
            'sg-1000'
            'msx'               
        )

        #Old mapping was 12triangle, 13circle, 14x, 15square
        #New mapping is 0x, 1circle, 2triangle, 3square
        #Before, we were setting Jump (a) to the Square button (15)
        #   and Fire (b) to the Cross (14) button
        #   and then Aux (y) to the Circle (13) button
        #   ...heretofore: we want to set y to 1, a to 3, and b to 0


        for emu in "${emulatorsToButtonSwapReverse[@]}"; do
            emu=($emu)
            iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
            iniUnset "input_player1_y_btn" "1"
            iniUnset "input_player1_a_btn" "3"
            iniUnset "input_player1_b_btn" "0"
            iniUnset "input_player2_y_btn" "1"
            iniUnset "input_player2_a_btn" "3"
            iniUnset "input_player2_b_btn" "0"
            iniUnset "input_player3_y_btn" "1"
            iniUnset "input_player3_a_btn" "3"
            iniUnset "input_player3_b_btn" "0"
            iniUnset "input_player4_y_btn" "1"
            iniUnset "input_player4_a_btn" "3"
            iniUnset "input_player4_b_btn" "0"
        done

        # echo "Remapping more individual emulator buttons to be more sensible - for systems that want to use Circle for jump and X for fire we will remap to use X for jump and Square for fire..."
        # #local
        # #above keyword only for when below is in its own function:
        # emulatorsToButtonSwapReverse=(
        #     'atarilynx'      
        # )

        # for emu in "${emulatorsToButtonSwapReverse[@]}"; do
        #     emu=($emu)
        #     iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
        #     iniUnset "input_player1_a_btn" "0"
        #     iniUnset "input_player1_b_btn" "3"
        #     iniUnset "input_player2_a_btn" "0"
        #     iniUnset "input_player2_b_btn" "3"
        #     iniUnset "input_player3_a_btn" "0"
        #     iniUnset "input_player3_b_btn" "3"
        #     iniUnset "input_player4_a_btn" "0"
        #     iniUnset "input_player4_b_btn" "3"                        
        # done

        echo "Clearing remaps for more individual emulator buttons to be more sensible - for systems that want to use Circle for fire and X for jump we will remap to use X for jump and Square for fire..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToButtonSwapReverse=(
            'atarilynx'
            'wonderswan'
            'wonderswancolor'        
        )

        for emu in "${emulatorsToButtonSwapReverse[@]}"; do
            emu=($emu)
            iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
            iniUnset "input_player1_a_btn" "3"
            iniUnset "input_player1_b_btn" "0"
            iniUnset "input_player2_a_btn" "3"
            iniUnset "input_player2_b_btn" "0"
            iniUnset "input_player3_a_btn" "3"
            iniUnset "input_player3_b_btn" "0"
            iniUnset "input_player4_a_btn" "3"
            iniUnset "input_player4_b_btn" "0"                        
        done

        echo "Rearranging horribly wrong emulator button mappings for MAME to be more generally usable..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToRearrangeButtons=(
            'mame-libretro'
            'mame2000'
            'mame2003'
            'mame2003-plus'
            'mame2010'
            'mame2015'
        )
        emulatorGameRemapFolderNames=(
            '.'
            'MAME 2000'
            'MAME 2003'
            'MAME 2003-PLUS'
            'MAME 2010'
            'MAME 2015'
        )

        for ((i=0;i<${#emulatorsToRearrangeButtons[@]};++i)); do
            emu="${emulatorsToRearrangeButtons[i]}"
            emuFolderName="${emulatorGameRemapFolderNames[i]}"
            gameSpecificRemapSourceFolder="/home/pi/primestationone/reference/opt/retropie/configs/mame-libretro"
            remapDestinationBaseFolder="${whichemuconfigdir}/mame-libretro"
            printf "Now processing emu %s with game remap folder name %s\n" "${emu}" "${emuFolderName}"
            mkdir -vp "${remapDestinationBaseFolder}/${emuFolderName}"

            #First, distribute the game-specific configurations for this emulator to the following games
            specificGamesToRemapToStreetFighterControls=(
                'sf1jp'
                'sf2j'
                'sf1us'
                'sf2rb'
                'sf1'
                'sf2red'
                'sf2accp2'
                'sf2tj'
                'sf2a'
                'sf2t'
                'sf2b'
                'sf2'
                'sf2cea'
                'sfeverbw'
                'sf2ceb'
                'sfiii3n'
                'sf2cej'
                'sfootbal'
                'sf2ce'
                'sformula'
                'sf2e'
                'sfposeid'
                'sf2jb'
            )
            echo "Remapping Street Fighter-style arcade game controls..."
            for game in "${specificGamesToRemapToStreetFighterControls[@]}"; do
                game=($game)
                cp -vf "${gameSpecificRemapSourceFolder}/streetfighter.rmp" "${remapDestinationBaseFolder}/${emuFolderName}/${game}.rmp"
            done

            specificGamesToRemapToMortalKombatControls=(
                'mk2r14'
                'mk2r32'
                'mk2'
                'mk3r10'
                'mk3r20'
                'mk3'
                'mkla1'
                'mkla2'
                'mkla3'
                'mkla4'
                'mk'
            )
            echo "Remapping Mortal Kombat-style arcade game controls..."
            for game in "${specificGamesToRemapToMortalKombatControls[@]}"; do
                game=($game)
                cp -vf "${gameSpecificRemapSourceFolder}/mortalkombat12.rmp" "${remapDestinationBaseFolder}/${emuFolderName}/${game}.rmp"
            done

            echo "Changing ownership of remap files to pi..."
            chown -Rv pi:pi "${remapDestinationBaseFolder}"

            echo "Now remapping all other arcade games to use X for jump / main and square for fire / secondary..."
            iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"

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

            # iniUnset "input_player1_b_btn"
            # iniUnset "input_player1_y_btn"

            # iniUnset "input_player2_b_btn"
            # iniUnset "input_player2_y_btn"

            # iniUnset "input_player3_b_btn"
            # iniUnset "input_player3_y_btn"

            # iniUnset "input_player4_b_btn"
            # iniUnset "input_player4_y_btn"



            iniUnset "input_player1_y_btn" "1"
            iniUnset "input_player1_a_btn" "0"
            iniUnset "input_player1_b_btn" "3"
            iniUnset "input_player2_y_btn" "1"
            iniUnset "input_player2_a_btn" "0"
            iniUnset "input_player2_b_btn" "3"
            iniUnset "input_player3_y_btn" "1"
            iniUnset "input_player3_a_btn" "0"
            iniUnset "input_player3_b_btn" "3"
            iniUnset "input_player4_y_btn" "1"
            iniUnset "input_player4_a_btn" "0"
            iniUnset "input_player4_b_btn" "3"



            # iniSet "input_player1_b_btn" "3"
            # iniSet "input_player1_y_btn" "0"

            # iniSet "input_player2_b_btn" "3"
            # iniSet "input_player2_y_btn" "0"

            # iniSet "input_player3_b_btn" "3"
            # iniSet "input_player3_y_btn" "0"

            # iniSet "input_player4_b_btn" "3"
            # iniSet "input_player4_y_btn" "0"

        done
    else
        echo "$whichemuconfigdir does not exist, skipping!"
    fi
done

# echo "Configuring Dreamcast Reicast PS3 controls..."
#python /home/pi/primestationone/bin/dreamcastMapPs3ControlsForReicast.py
# sudo cp -vr opt/retropie/configs/dreamcast/emu.cfg opt/retropie/configs/dreamcast/

# echo "Configuring N64 non-libretrocore PS3 controls..."
# sudo cp -vr opt/retropie/configs/n64/InputAutoCfg.ini opt/retropie/configs/n64/



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

#Need to set the following in /opt/retropie/configs/all/retroarch.cfg to fix the hotkey enable bug
# input_enable_hotkey = "alt"
# input_enable_hotkey_axis = "nul"
# input_enable_hotkey_btn = "10"
# input_enable_hotkey_mbtn = "nul"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniSet "input_enable_hotkey" "alt"
iniSet "input_enable_hotkey_axis" "nul"
# iniSet "input_enable_hotkey_btn" "10"
iniUnset "input_enable_hotkey_btn"
iniSet "input_enable_hotkey_mbtn" "nul"
