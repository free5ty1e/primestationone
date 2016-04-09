#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
pushd ~

if [ -z "${17}" ]
then
    echo "Possible fonts are as follows..."
    convert -list font | grep Font:

    echo ""
    echo "."
    echo "Usage: the first 17 arguments are <required>!  The last 3 are [optional]."
    echo "createAnsiFontText.sh <filenamePrefix> <text1size> <text1color> <text1font> <text1> <text2size> <text2color> <text2font> <text2> <text3size> <text3color> <text3font> <text3> <text4size> <text4color> <text4font> <text4> [ansiWidthInChars] [backgroundColor] [marginSquash]"
    echo ""
    echo "Example:"
    echo "createAnsiFontText.sh primestationfancytextimage 200 'white' 'Helvetica-BoldOblique' '.P.R.I.M.E.' 200 'yellow' 'URW-Palladio-L-Bold' '.S.T.A.T.I.O.N.' 200 'blue' 'Bitstream-Charter-Bold' '.O.N.E.' 200 'green' 'Liberation-Mono-Bold' 'v1.00' 160 'black' 35"
    echo "...will create a primestationfancytextimage.png and a primestationfancytextimage.ansi (160 characters wide) on a black background with the specified 4 lines of text in the specified colors all sized at 200pt and a marginsquash of 35pt (larger = less vertical space between text, possibly overlapping)"
    echo "."
    echo ""
else
    fancy_console_message "Generating fancy text ANSI art..." unipony

    filenameprefix="$1"
    echo "Filename prefix: $filenameprefix"

    #Text Line 1:
    size1=$2
    echo "Size1: $size1 pt."
    color1="$3"
    echo "Color1: $color1"
    font1="$4"
    echo "Font1: $font1"
    text1="$5"
    echo "Text1: $text1"

    #Text Line 2:
    size2=$6
    echo "Size2: $size2 pt."
    color2="$7"
    echo "Color2: $color2"
    font2="$8"
    echo "Font2: $font2"
    text2="$9"
    echo "Text2: $text2"

    #Text Line 3:
    size3=${10}
    echo "Size3: $size3 pt."
    color3="${11}"
    echo "Color3: $color3"
    font3="${12}"
    echo "Font3: $font3"
    text3="${13}"
    echo "Text3: $text3"

    #Text Line 4:
    size4=${14}
    echo "Size4: $size4 pt."
    color4="${15}"
    echo "Color4: $color4"
    font4="${16}"
    echo "Font4: $font4"
    text4="${17}"
    echo "Text4: $text4"

    if [ -z "${18}" ]
    then
        canvasbackgroundcolor='black'
    else
        canvasbackgroundcolor="${18}"
    fi
    echo "CanvasBackgroundColor: $canvasbackgroundcolor"

    if [ -z "${19}" ]
    then
        marginsquash=35
    else
    marginsquash=${19}
    fi
    echo "MarginSquash: $marginsquash"

    if [ -z "${20}" ]
    then
        ansicharwidth=160
    else
        ansicharwidth=${20}
    fi
    echo "AnsiCharacterWidth: $ansicharwidth"

    rm canvas.png
    fudgepixels=4
    totalheight=$((size1+$size2+$size3+$size4-$marginsquash-$marginsquash-$marginsquash-$marginsquash+$fudgepixels))
    convert -size "1920x$totalheight" xc:"$canvasbackgroundcolor" canvas.png
    convert -pointsize $size1 -fill "$color1" -draw "text 0,$(($size1-$marginsquash)) \"$text1\"" -font "$font1" -pointsize $size2 -fill "$color2" -draw "text 0,$(($size1+$size2-$marginsquash-$marginsquash)) \"$text2\"" -font "$font2" -pointsize $size3 -fill "$color3" -draw "text 0,$(($size1+$size2+$size3-$marginsquash-$marginsquash-$marginsquash)) \"$text3\"" -font "$font3" -pointsize $size4 -fill "$color4" -draw "text 0,$(($size1+$size2+$size3+$size4-$marginsquash-$marginsquash-$marginsquash-$marginsquash)) \"$text4\"" -font "$font4" canvas.png "$filenameprefix.png"
    ansize "$filenameprefix.png" "$filenameprefix.ansi" $ansicharwidth
fi

popd
