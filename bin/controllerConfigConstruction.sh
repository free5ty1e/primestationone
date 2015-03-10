#!/bin/bash
echo Constructing the controller configs to match the splashscreen quick reference image...

pushd ~
mkdir temp
cd temp
for file in ~/primestationone/reference/opt/retropie/emulators/retroarch/configs/*.header.cfg; do
    filename=$(basename "$file")
    cfgextension="${filename##*.}"
    headerfilename="${filename%.*}"
    filename="${headerfilename%.*}"
    cat "$file" > "$filename.cfg"
    cat ~/primestationone/reference/opt/retropie/emulators/retroarch/configs/PS3Controller.master.cfg >> "$filename.cfg"
    echo "Constructed new controller config file: $filename.cfg with contents: "
    cat "$filename.cfg"
done
echo Installing constructed controller configs to RetroArch autoconfig folder...
sudo cp -vr ~/temp/*.cfg /opt/retropie/emulators/retroarch/configs/
rm ~/temp/*.cfg
popd
