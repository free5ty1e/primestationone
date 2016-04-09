#!/bin/bash

function install_go_and_ansize() {
    echo "Installing Go language and ANSIze image to ANSI converter..."

    install_package_universal golang

    mkdir "$HOME/gocode"

    if [ -f "$HOME/.bashrc" ]; then
        echo ".bashrc found, modifying..."
        echo "export GOPATH=$HOME/gocode" >> "$HOME/.bashrc"
    else
        echo "no .bashrc, guessing .bash_profile, modifying..."
        echo "export GOPATH=$HOME/gocode" >> "$HOME/.bash_profile"
    fi

    export "GOPATH=$HOME/gocode"
    go get github.com/nfnt/resize
    go get github.com/jhchen/ansize

    sudo cp "$GOPATH/bin/ansize" /usr/local/bin/
    ansize
}

function install_package_universal() {
    echo "Installing package $1 on all known package managers because: why not..."

    echo "CentOS / RedHat (yum) install, in case this be you..."
    sudo yum -y install "$1"

    echo "Debian (apt-get) install, in case this be you..."
    sudo apt-get install -y "$1"

    echo "Cygwin (pacman) install, in case this be you..."
    sudo pacman -y install "$1"

    echo "Mac OSX (brew) install, in case this be you..."
    brew install "$1"
}

function show_usage() {
    echo "****Possible fonts are as follows..."
    convert -list font | grep Font:

    echo ""
    echo "."
    echo "****Usage: either the first 2-5 arguments are <required>, or the first 17 arguments are <required>!  The last 3 are [optional]."
    echo ""
    echo "**Syntax for 17-20 argument call:"
    echo "createAnsiFontText.sh <filenamePrefix> <text1size> <text1color> <text1font> <text1> <text2size> <text2color> <text2font> <text2> <text3size> <text3color> <text3font> <text3> <text4size> <text4color> <text4font> <text4> [ansiWidthInChars] [backgroundColor] [marginSquash]"
    echo ""
    echo "**Syntax for 2-5 argument call: (will result in random font and random color for each text line, all sized @ 200pt && marginsquash of 35 && black background)"
    echo "createAnsiFontText.sh <filenamePrefix> <text1> [text2] [text3] [text4]"
    echo ""
    echo "Example:"
    echo "createAnsiFontText.sh primestationfancytextimage 200 'white' 'Helvetica-BoldOblique' '.P.R.I.M.E.' 200 'yellow' 'URW-Palladio-L-Bold' '.S.T.A.T.I.O.N.' 200 'blue' 'Bitstream-Charter-Bold' '.O.N.E.' 200 'green' 'Liberation-Mono-Bold' 'v1.00' 'black' 35 160"
    echo "...will create a primestationfancytextimage.png and a primestationfancytextimage.ansi (160 characters wide) on a black background with the specified 4 lines of text in the specified colors all sized at 200pt and a marginsquash of 35pt (larger = less vertical space between text, possibly overlapping)"
    echo "."
    echo ""
}


source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
pushd "$HOME"

if [ ! -f "/usr/bin/convert" ]; then
    install_package_universal imagemagick
fi

if [ ! -f "/usr/local/bin/ansize" ]; then
    install_go_and_ansize
fi

if [ -z "${17}" ]
then
    if [ -z "$2" ]
    then
        show_usage
    else    #if parameter 17 is empty but parameter 2 is not, then assume we want to just pass in the filenameprefix and up to 4 strings
        fancy_console_message "Generating fancy text ANSI art from short-form call..." vader
        sizeall=200
        filenameprefix="$1"
        echo "Filename prefix: $filenameprefix"

        echo "Setting default sizes..."
        size1=$sizeall
        size2=$sizeall
        size3=$sizeall
        size4=$sizeall

        echo "Selecting random colors..."
        colors=("white" "yellow" "orange" "red" "green" "blue" "brown" "turquoise" "SlateGrey")
        color1=${colors[$RANDOM % ${#colors[@]} ]}
        color2=${colors[$RANDOM % ${#colors[@]} ]}
        color3=${colors[$RANDOM % ${#colors[@]} ]}
        color4=${colors[$RANDOM % ${#colors[@]} ]}

        echo "Selecting random fonts..."
        fonts=("Helvetica-BoldOblique" "URW-Palladio-L-Bold" "Bitstream-Charter-Bold" "Liberation-Mono-Bold" "DejaVu-Sans-Bold" "FreeSerif-Bold" "brown" "turquoise" "SlateGrey")
        font1=${fonts[$RANDOM % ${#fonts[@]} ]}
        font2=${fonts[$RANDOM % ${#fonts[@]} ]}
        font3=${fonts[$RANDOM % ${#fonts[@]} ]}
        font4=${fonts[$RANDOM % ${#fonts[@]} ]}

        canvasbackgroundcolor='black'
        echo "CanvasBackgroundColor: $canvasbackgroundcolor"

        marginsquash=35
        echo "MarginSquash: $marginsquash"

        ansicharwidth=160
        echo "AnsiCharacterWidth: $ansicharwidth"

        rm canvas.png
        fudgepixels=4

        #Text Line 1:
        echo "Size1: $size1 pt."
        echo "Color1: $color1"
        echo "Font1: $font1"
        text1="$2"
        echo "Text1: $text1"

        #Optional Text Line 2:
        if [ -z "$3" ]
        then
            echo "No text2!"

            totalheight=$((size1-$marginsquash+$fudgepixels))
            convert -size "1920x$totalheight" xc:"$canvasbackgroundcolor" canvas.png
            convert -pointsize $size1 -fill "$color1" -draw "text 0,$(($size1-$marginsquash)) \"$text1\"" -font "$font1" canvas.png "$filenameprefix.png"

        else
            echo "Size2: $size2 pt."
            echo "Color2: $color2"
            echo "Font2: $font2"
            text2="$3"
            echo "Text2: $text2"

            #Optional Text Line 3:
            if [ -z "$4" ]
            then
                echo "No text3!"

                totalheight=$((size1+$size2-$marginsquash-$marginsquash+$fudgepixels))
                convert -size "1920x$totalheight" xc:"$canvasbackgroundcolor" canvas.png
                convert -pointsize $size1 -fill "$color1" -draw "text 0,$(($size1-$marginsquash)) \"$text1\"" -font "$font1" -pointsize $size2 -fill "$color2" -draw "text 0,$(($size1+$size2-$marginsquash-$marginsquash)) \"$text2\"" -font "$font2" canvas.png "$filenameprefix.png"

            else
                echo "Size3: $size3 pt."
                echo "Color3: $color3"
                echo "Font3: $font3"
                text2="$4"
                echo "Text3: $text3"

                #Optional Text Line 4:
                if [ -z "$5" ]
                then
                    echo "No text4!"

                    totalheight=$((size1+$size2+$size3-$marginsquash-$marginsquash-$marginsquash+$fudgepixels))
                    convert -size "1920x$totalheight" xc:"$canvasbackgroundcolor" canvas.png
                    convert -pointsize $size1 -fill "$color1" -draw "text 0,$(($size1-$marginsquash)) \"$text1\"" -font "$font1" -pointsize $size2 -fill "$color2" -draw "text 0,$(($size1+$size2-$marginsquash-$marginsquash)) \"$text2\"" -font "$font2" -pointsize $size3 -fill "$color3" -draw "text 0,$(($size1+$size2+$size3-$marginsquash-$marginsquash-$marginsquash)) \"$text3\"" -font "$font3" canvas.png "$filenameprefix.png"

                else
                    echo "Size4: $size4 pt."
                    echo "Color4: $color4"
                    echo "Font4: $font4"
                    text2="$5"
                    echo "Text4: $text4"

                    totalheight=$((size1+$size2+$size3+$size4-$marginsquash-$marginsquash-$marginsquash-$marginsquash+$fudgepixels))
                    convert -size "1920x$totalheight" xc:"$canvasbackgroundcolor" canvas.png
                    convert -pointsize $size1 -fill "$color1" -draw "text 0,$(($size1-$marginsquash)) \"$text1\"" -font "$font1" -pointsize $size2 -fill "$color2" -draw "text 0,$(($size1+$size2-$marginsquash-$marginsquash)) \"$text2\"" -font "$font2" -pointsize $size3 -fill "$color3" -draw "text 0,$(($size1+$size2+$size3-$marginsquash-$marginsquash-$marginsquash)) \"$text3\"" -font "$font3" -pointsize $size4 -fill "$color4" -draw "text 0,$(($size1+$size2+$size3+$size4-$marginsquash-$marginsquash-$marginsquash-$marginsquash)) \"$text4\"" -font "$font4" canvas.png "$filenameprefix.png"
                fi
            fi
        fi
        ansize "$filenameprefix.png" "$filenameprefix.ansi" $ansicharwidth
    fi
else
    fancy_console_message "Generating fancy text ANSI art from long-form call..." unipony

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
