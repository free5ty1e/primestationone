#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
pushd ~

cowsay -l
#apt beavis.zen bong bud-frogs bunny calvin cheese cock cower daemon default
#dragon dragon-and-cow duck elephant elephant-in-snake eyes flaming-sheep
#ghostbusters gnu head-in hellokitty kiss kitty koala kosh luke-koala
#mech-and-cow meow milk moofasa moose mutilated pony pony-smaller ren sheep
#skeleton snowman sodomized-sheep stegosaurus stimpy suse three-eyes turkey
#turtle tux unipony unipony-smaller vader vader-koala www

fancy_console_message "Generating splashscreen ANSI art..." unipony
ansize splashscreen.png splashscreen.ansi 160

fancy_console_message "Generating Beavis and Butthead ANSI art..." unipony
wget https://pbs.twimg.com/profile_images/2221189782/beavis_butthead.jpg
ansize beavis_butthead.jpg beavis_butthead.ansi 160

primestationversion=$(cat /home/pi/primestationone/reference/txt/version.txt)
createAnsiFontText.sh primestationfancytextimage 200 'white' 'Helvetica-BoldOblique' '.P.R.I.M.E.' 200 'yellow' 'URW-Palladio-L-Bold' '.S.T.A.T.I.O.N.' 200 'blue' 'Bitstream-Charter-Bold' '.O.N.E.' 200 'green' 'Liberation-Mono-Bold' "$primestationversion"
popd
