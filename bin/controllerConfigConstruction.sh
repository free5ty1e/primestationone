#!/bin/bash
echo Constructing the controller configs en masse to ALL match the splashscreen quick reference image...
echo This will also enable non-PS3 controllers to map closely to the splashscreen instead of being way off...

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"

md_build="/home/pi/temp/joypadautoconfig"
emudir="/opt/retropie/emulators"

function remap_hotkeys_retroarchautoconf() {
    local file="$1"
    local ini_value

    [[ -z "$file" || ! -f "$file" ]] && return 1


    printMsgs "console" "Processing $file"

    iniGet "input_device" "$file"
    if [[ $ini_value == *"PLAYSTATION(R)3"* ]] then
        echo Controller with PS button detected!  Inserting missing PS button mapping...
        iniSet "input_ps" "16" "$file" >/dev/null
    fi

    iniConfig " = " "\""
    local mappings=(
        'input_enable_hotkey input_select'
        'input_exit_emulator input_start'
        'input_menu_toggle input_l'
        'input_load_state input_b'
        'input_save_state input_y'
        'input_reset input_up'
        'input_state_slot_increase input_r'
        'input_state_slot_decrease input_r2'
        'input_disk_eject_toggle input_left'
        'input_disk_next input_right'
        'input_analog_dpad_mode input_down'
        'input_movie_record_toggle input_r3'
        'input_screenshot input_l3'
        'input_rewind input_r_x_minus'
        'input_hold_fast_forward input_r_x_plus'
        'input_toggle_fast_forward input_a
        'input_pause_toggle input_start'
        'input_frame_advance input_r_y_minus'
        'input_slowmotion input_r_y_plus'
        'input_netplay_flip_players input_l2'
        'input_volume_up input_l_y_minus'
        'input_volume_down_axis input_l_y_plus'
        'input_turbo_btn input_x'
        'input_exit_emulator input_ps'
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

    echo Wiping out any existing controller autoconfigs
    sudo rm -rf "$emudir/retroarch/configs"

    echo Installing retroarch joypad base autoconfigs...
    sudo mkdir -p "$emudir/retroarch/configs/"

    echo Stripping CRs from the autoconfigs....
    sudo cd "$md_build/udev/"
    for file in *; do
        sudo tr -d '\015' <"$file" >"$emudir/retroarch/configs/$file"
        sudo chown $user:$user "$emudir/retroarch/configs/$file"
    done

    echo Mapping special functions to match Primestation splashscreen...
    printMsgs "console" "Remapping controller hotkeys"

    for file in "$emudir/retroarch/configs/"*; do
        sudo remap_hotkeys_retroarchautoconf "$file"
    done




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
