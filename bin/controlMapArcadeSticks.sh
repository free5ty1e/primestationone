#!/bin/bash

echo "Mapping arcade sticks..."

retropiebase="/opt/retropie"
emudir="$retropiebase/emulators"
configdir="$emudir/retroarch/configs"
newretropieconfigsdir="$retropiebase/configs"
allconfigsdir="$newretropieconfigsdir/all/retroarch-joypads"

configdirs=(
    "$allconfigsdir"
)

emuconfigdirs=(
    "$newretropieconfigsdir"
)


for whichemuconfigdir in "${emuconfigdirs[@]}"; do
    if [ -d "$whichemuconfigdir" ]; then
        # echo "Remapping individual emulator buttons for config dir ${whichemuconfigdir} to be more sensible and use Square for B instead of Cross for B which is asinine..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToButtonSwap=(
            'nes'
            'gb'
            'gbc'
            'gba'
            'n64'
            'pcengine'
            'supergrafx'
        )

        #Old mapping was 12triangle, 13circle, 14x, 15square
        #New mapping is 0x, 1circle, 2triangle, 3square
        #Before, we were setting Jump (a) to the Cross button (14)
        #   and Fire (b) to the Square (15) button instead of Circle (13) which is the default
        #   and then Aux (y) to the Circle (13) button instead of the Square (15) button which is the default
        #   ...heretofore: we want to set y to 1, a to 0, and b to 3

        # for emu in "${emulatorsToButtonSwap[@]}"; do
        #     emu=($emu)
        #     iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
        #     iniSet "input_player1_y_btn" "1"
        #     iniSet "input_player1_a_btn" "0"
        #     iniSet "input_player1_b_btn" "3"
        #     iniSet "input_player2_y_btn" "1"
        #     iniSet "input_player2_a_btn" "0"
        #     iniSet "input_player2_b_btn" "3"
        #     iniSet "input_player3_y_btn" "1"
        #     iniSet "input_player3_a_btn" "0"
        #     iniSet "input_player3_b_btn" "3"
        #     iniSet "input_player4_y_btn" "1"
        #     iniSet "input_player4_a_btn" "0"
        #     iniSet "input_player4_b_btn" "3"
        # done

        # echo "Remapping more individual emulator buttons to be more sensible and use Square for attack instead of Cross which is asinine..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToButtonSwapReverse=(
            'gamegear'
            'mastersystem'
            'sg-1000'
            'msx'    
            'atarilynx'            
        )

        #Old mapping was 12triangle, 13circle, 14x, 15square
        #New mapping is 0x, 1circle, 2triangle, 3square
        #Before, we were setting Jump (a) to the Square button (15)
        #   and Fire (b) to the Cross (14) button
        #   and then Aux (y) to the Circle (13) button
        #   ...heretofore: we want to set y to 1, a to 3, and b to 0


        # for emu in "${emulatorsToButtonSwapReverse[@]}"; do
        #     emu=($emu)
        #     iniConfig " = " "" "$whichemuconfigdir/$emu/retroarch.cfg"
        #     iniSet "input_player1_y_btn" "1"
        #     iniSet "input_player1_a_btn" "3"
        #     iniSet "input_player1_b_btn" "0"
        #     iniSet "input_player2_y_btn" "1"
        #     iniSet "input_player2_a_btn" "3"
        #     iniSet "input_player2_b_btn" "0"
        #     iniSet "input_player3_y_btn" "1"
        #     iniSet "input_player3_a_btn" "3"
        #     iniSet "input_player3_b_btn" "0"
        #     iniSet "input_player4_y_btn" "1"
        #     iniSet "input_player4_a_btn" "3"
        #     iniSet "input_player4_b_btn" "0"
        # done



        echo "Applying arcade stick remaps for MAME emulators..."
        #local
        #above keyword only for when below is in its own function:
        emulatorsToRearrangeButtons=(
            'mame-libretro'
            'mame2000'
            'mame2003'
            'mame2003'
            'mame2003-plus'
            'mame2010'
            'mame2014'
            'mame2015'
        )
        emulatorGameRemapFolderNames=(
            '.'
            'MAME 2000'
            'MAME 2003'
            'MAME 2003 (0.78)'
            'MAME 2003-PLUS'
            'MAME 2010'
            'MAME 2014'
            'MAME 2015'
        )

        for ((i=0;i<${#emulatorsToRearrangeButtons[@]};++i)); do
            emu="${emulatorsToRearrangeButtons[i]}"
            emuFolderName="${emulatorGameRemapFolderNames[i]}"
            gameSpecificRemapSourceFolder="/home/pi/primestationone/reference/opt/retropie/configs/mame-libretro/arcadesticks"
            remapDestinationBaseFolder="${whichemuconfigdir}/mame-libretro"
            printf "Now processing emu %s with game remap folder name %s\n" "${emu}" "${emuFolderName}"
            mkdir -vp "${remapDestinationBaseFolder}/${emuFolderName}"

            #First, copy the mame remapping file in:
            cp -vf "${gameSpecificRemapSourceFolder}/mame.rmp" "${remapDestinationBaseFolder}/${emuFolderName}/${emuFolderName}.rmp"

            #Next, distribute the game-specific configurations for this emulator to the following games
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


            # specificGamesToRemapDialControls=(
            #     'forgottn'
            # )
            # echo "Remapping dial arcade game controls..."
            # for game in "${specificGamesToRemapDialControls[@]}"; do
            #     game=($game)
            #     cp -vf "${gameSpecificRemapSourceFolder}/forgottenworlds.rmp" "${remapDestinationBaseFolder}/${emuFolderName}/${game}.rmp"
            # done            


            # echo "Changing ownership of remap files to pi..."
            # chown -Rv pi:pi "${remapDestinationBaseFolder}"

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



        done
    else
        echo "$whichemuconfigdir does not exist, skipping!"
    fi
done

