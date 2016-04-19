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
rm beavis_butthead.jpg
wget https://pbs.twimg.com/profile_images/2221189782/beavis_butthead.jpg
ansize beavis_butthead.jpg beavis_butthead.ansi 160

rm cornholio.jpg
wget http://i.imgur.com/vHCzBxU.jpg
mv vHCzBxU.jpg cornholio.jpg
ansize cornholio.jpg cornholio.ansi 160

#Listing fonts by calling without arguments:
createAnsiFontText.sh
#Font: AvantGarde-Book
#Font: AvantGarde-BookOblique
#Font: AvantGarde-Demi
#Font: AvantGarde-DemiOblique
#Font: Bookman-Demi
#Font: Bookman-DemiItalic
#Font: Bookman-Light
#Font: Bookman-LightItalic
#Font: Courier
#Font: Courier-Bold
#Font: Courier-BoldOblique
#Font: Courier-Oblique
#Font: fixed
#Font: Helvetica
#Font: Helvetica-Bold
#Font: Helvetica-BoldOblique
#Font: Helvetica-Narrow
#Font: Helvetica-Narrow-Bold
#Font: Helvetica-Narrow-BoldOblique
#Font: Helvetica-Narrow-Oblique
#Font: Helvetica-Oblique
#Font: NewCenturySchlbk-Bold
#Font: NewCenturySchlbk-BoldItalic
#Font: NewCenturySchlbk-Italic
#Font: NewCenturySchlbk-Roman
#Font: Palatino-Bold
#Font: Palatino-BoldItalic
#Font: Palatino-Italic
#Font: Palatino-Roman
#Font: Symbol
#Font: Times-Bold
#Font: Times-BoldItalic
#Font: Times-Italic
#Font: Times-Roman
#Font: Bitstream-Charter
#Font: Bitstream-Charter-Bold
#Font: Bitstream-Charter-Bold-Italic
#Font: Bitstream-Charter-Italic
#Font: Century-Schoolbook-L-Bold
#Font: Century-Schoolbook-L-Bold-Italic
#Font: Century-Schoolbook-L-Italic
#Font: Century-Schoolbook-L-Roman
#Font: Courier-10-Pitch
#Font: Courier-10-Pitch-Bold
#Font: Courier-10-Pitch-Bold-Italic
#Font: Courier-10-Pitch-Italic
#Font: DejaVu-Sans
#Font: DejaVu-Sans-Bold
#Font: DejaVu-Sans-Mono
#Font: DejaVu-Sans-Mono-Bold
#Font: DejaVu-Serif
#Font: DejaVu-Serif-Bold
#Font: Dingbats
#Font: FreeMono
#Font: FreeMono-Bold
#Font: FreeMono-Bold-Oblique
#Font: FreeMono-Oblique
#Font: FreeSans
#Font: FreeSans-Bold
#Font: FreeSans-Bold-Oblique
#Font: FreeSans-Oblique
#Font: FreeSerif
#Font: FreeSerif-Bold
#Font: FreeSerif-Bold-Italic
#Font: FreeSerif-Italic
#Font: Liberation-Mono
#Font: Liberation-Mono-Bold
#Font: Liberation-Mono-Bold-Italic
#Font: Liberation-Mono-Italic
#Font: Liberation-Sans
#Font: Liberation-Sans-Bold
#Font: Liberation-Sans-Bold-Italic
#Font: Liberation-Sans-Italic
#Font: Liberation-Sans-Narrow
#Font: Liberation-Sans-Narrow-Bold
#Font: Liberation-Sans-Narrow-Bold-Italic
#Font: Liberation-Sans-Narrow-Italic
#Font: Liberation-Serif
#Font: Liberation-Serif-Bold
#Font: Liberation-Serif-Bold-Italic
#Font: Liberation-Serif-Italic
#Font: Nimbus-Mono-L
#Font: Nimbus-Mono-L-Bold
#Font: Nimbus-Mono-L-Bold-Oblique
#Font: Nimbus-Mono-L-Regular-Oblique
#Font: Nimbus-Roman-No9-L
#Font: Nimbus-Roman-No9-L-Medium
#Font: Nimbus-Roman-No9-L-Medium-Italic
#Font: Nimbus-Roman-No9-L-Regular-Italic
#Font: Nimbus-Sans-L
#Font: Nimbus-Sans-L-Bold
#Font: Nimbus-Sans-L-Bold-Condensed
#Font: Nimbus-Sans-L-Bold-Condensed-Italic
#Font: Nimbus-Sans-L-Bold-Italic
#Font: Nimbus-Sans-L-Regular-Condensed
#Font: Nimbus-Sans-L-Regular-Condensed-Italic
#Font: Nimbus-Sans-L-Regular-Italic
#Font: Standard-Symbols-L
#Font: URW-Bookman-L-Demi-Bold
#Font: URW-Bookman-L-Demi-Bold-Italic
#Font: URW-Bookman-L-Light
#Font: URW-Bookman-L-Light-Italic
#Font: URW-Chancery-L-Medium-Italic
#Font: URW-Gothic-L-Book
#Font: URW-Gothic-L-Book-Oblique
#Font: URW-Gothic-L-Demi
#Font: URW-Gothic-L-Demi-Oblique
#Font: URW-Palladio-L-Bold
#Font: URW-Palladio-L-Bold-Italic
#Font: URW-Palladio-L-Italic
#Font: URW-Palladio-L-Roman

primestationversion=$(cat /home/pi/primestationone/reference/txt/version.txt)
createAnsiFontText.sh primestationfancytextimage 200 'white' 'Helvetica-BoldOblique' '.P.R.I.M.E.' 200 'yellow' 'URW-Palladio-L-Bold' '.S.T.A.T.I.O.N.' 200 'blue' 'Bitstream-Charter-Bold' '.O.N.E.' 200 'green' 'Liberation-Mono-Bold' "$primestationversion" 'black' 35 160
popd
