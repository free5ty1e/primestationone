#!/bin/bash

source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"

function multiply() {
    echo "Multiplying $1 x $2 with bc, storing raw float value in ANS_FLOAT, storing rounded integer in ANS"
    ANS_FLOAT=$(echo "${1}*${2}" |bc)
    printf -v ANS %.0f "$ANS_FLOAT"
}

function fancy_console_message() {
#Parameters: consoleMessage optionalCowsayFile
    consoleMessage="$1"
    if [ -z "$2" ]
    then
        cowsay "$consoleMessage"
    else
        cowsay -f "$2" "$consoleMessage"
    fi
    echo "$consoleMessage"
}

function reset_permissions_bios_and_roms() {
    echo Resetting permissions on roms and BIOS folders...
    sudo chmod -R 755 /home/pi/RetroPie
}

function rsync_with_progress() {
    echo "rsync with progress by file count, local filesystems only..."
    RSYNC="ionice -c3 rsync"
    # don't use --progress
    RSYNC_ARGS="-axv --stats --human-readable"
    SOURCES="$1"
    TARGET="$2"

    echo "Executing dry-run to see how many files must be transferred..."
    TODO=$(${RSYNC} --dry-run ${RSYNC_ARGS} ${SOURCES} ${TARGET}|grep "^Number of files transferred"|awk '{print $5}')
    #TODO=$(find ${SOURCES} | wc -l)
    echo "$TODO files counted to sync..."

    ${RSYNC} ${RSYNC_ARGS} ${SOURCES} ${TARGET} | pv -l -e -p -s "$TODO"
    #ionice -c3 rsync -xvrltD --delete --stats --human-readable "$1" "$2" | pv -l -e -p -s "$TODO"
}

function ask_for_user_input_and_store_result() {
    echo Parameters for this function are, in order:
    echo Title Backtitle InputBoxTitle optionalIsPassword optionalHeight optionalWidth optionalDefaultValue
    echo The result will be stored in the global variable named RESULT
    echo The user selection code will be stored in the global variable SEL if needed

    if [ -z "$4" ]
    then
        echo "No optionalIsPassword supplied, defaulting to isNotPassword 0"
        isPassword=0
    else
        isPassword=$4
    fi

    if [ -z "$5" ]
    then
        height=0
    else
        height=$5
    fi

    if [ -z "$6" ]
    then
        width=0
    else
        width=$6
    fi

    if [ -z "$7" ]
    then
        defaultValue=""
    else
        defaultValue="$7"
    fi

    if [ $isPassword -eq 1 ]
    then
        dialog --title "$1" --backtitle "$2" --passwordbox "$3" $height $width 2>/tmp/input.$$
    else
        dialog --title "$1" --backtitle "$2" --inputbox "$3" $height $width "$defaultValue" 2>/tmp/input.$$
    fi

    SEL=$?
    RESULT=`cat /tmp/input.$$`
    case $SEL in
        0) echo "RESULT obtained: $RESULT" ;;
        1) echo "Cancel pressed" ;;
        255) echo "[ESCAPE] key pressed" ;;
    esac
    rm -f /tmp/input.$$

}

function create_megarc_login_file() {
    echo Parameters for this function are: email password
    email="$1"
    password="$2"
    echo "Creating your .megarc file from provided email $email and not printing your password out of courtesy, you are welcome..."
    cat > /home/pi/.megarc << _EOF_
[Login]
Username = $email
Password = $password
_EOF_
}

function prepare_to_directly_run_retropie_script_modules() {
    # global variables ==========================================================

    # main retropie install location
    rootdir="/opt/retropie"

    user="$SUDO_USER"
    [[ -z "$user" ]] && user=$(id -un)

    home="$(eval echo ~$user)"
    datadir="$home/RetroPie"
    biosdir="$datadir/BIOS"
    romdir="$datadir/roms"
    emudir="$rootdir/emulators"
    configdir="$rootdir/configs"

    scriptdir="/home/pi/RetroPie-Setup"
    __logdir="$scriptdir/logs"
    __tmpdir="$scriptdir/tmp"
    __builddir="$__tmpdir/build"
    __swapdir="$__tmpdir"

    # check, if sudo is used
    if [[ $(id -u) -ne 0 ]]; then
    echo "Script must be run as root. Try 'sudo $0'"
    exit 1
    fi

    __backtitle="PetRockBlock.com - RetroPie Setup. Installation folder: $rootdir for user $user"

    source "$scriptdir/scriptmodules/system.sh"
    source "$scriptdir/scriptmodules/helpers.sh"
    source "$scriptdir/scriptmodules/packages.sh"
    source "$scriptdir/scriptmodules/admin/setup.sh"

    setup_env

    # set default gcc version
    gcc_version "$__default_gcc_version"

    mkUserDir "$romdir"
    mkUserDir "$biosdir"

    rp_registerAllModules

    ensureFBMode 320 240

}

function download_install_mega_module_on_the_fly() {
    echo "Function download_install_mega_module_on_the_fly() with parameters:"
    echo "Mega module / archive name: $1"
    archiveName="$1"
    echo "Install location: $2"
    installLocation="$2"
    echo "Archive size in bytes: $3"
    archiveSize="$3"
    echo "Mega DL link: $4"
    megaLink="$4"

    if [ -z "$5" ]
    then
        echo "No stripComponentCount supplied, defaulting to stripComponentCount 0"
        stripComponentCount=0
    else
        stripComponentCount=$5
    fi
    echo "Stripping Component Count: $stripComponentCount"

    echo "Checking for at least enough free space to contain the archive size * 1.5 average expansion factor..."
    multiply $archiveSize 1.5
    confirmRequiredDiskSpaceMB $((ANS/1024/1024))

    message="Downloading and installing $archiveName mega module on-the-fly with no archive or temp files..."
    echo "$message"
    cowsay -f flaming-sheep "$message"

    mkdir -p "$installLocation"
    pushd "$installLocation"

    echo Downloading archive from Mega and decompressing it on the fly...

    if [ $stripComponentCount -gt 0 ]
    then
        megadl --no-progress --path=- "$megaLink" | pv -p -s "$archiveSize" | tar xvj --strip-components=$stripComponentCount
    else
        megadl --no-progress --path=- "$megaLink" | pv -p -s "$archiveSize" | tar xvj
    fi

    popd
    echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
}

function download_install_mega_archive_from_cloud_storage_on_the_fly() {
    echo "Function download_install_mega_archive_from_cloud_storage_on_the_fly() with parameters:"
    echo "1: Mega module / archive name: $1"
    archiveName="$1"
    echo "2: Install location: $2"
    installLocation="$2"
    echo "3: Archive size in bytes: $3"
    archiveSize="$3"
    echo "4: Mega file location: $4"
    megaLink="$4"

    if [ -z "$5" ]
    then
        echo "No stripComponentCount supplied, defaulting to stripComponentCount 0"
        stripComponentCount=0
    else
        stripComponentCount=$5
    fi
    echo "5: Stripping Component Count: $stripComponentCount"

    echo "Checking for at least enough free space to contain the archive size * 1.5 average expansion factor..."
    multiply $archiveSize 1.5
    confirmRequiredDiskSpaceMB $((ANS/1024/1024))

    message="Downloading and installing $archiveName mega module on-the-fly with no archive or temp files..."
    echo "$message"
    cowsay -f flaming-sheep "$message"

    mkdir -p "$installLocation"
    pushd "$installLocation"

    echo Downloading archive from Mega and decompressing it on the fly...

    if [ $stripComponentCount -gt 0 ]
    then
        megaget --no-progress --path=- "$megaLink" | pv -p -s "$archiveSize" | tar xvj --strip-components=$stripComponentCount
    else
        megaget --no-progress --path=- "$megaLink" | pv -p -s "$archiveSize" | tar xvj
    fi

    popd
}

function cloud_create_backup_archive {
    echo "Function cloud_create_backup_archive() with parameters:"
    echo "1: Full path to BACKUPARCHIVEFILE: $1"
    BACKUPARCHIVEFILE="$1"

    echo "Clearing any current archive with this name: $BACKUPARCHIVEFILE.tar and $BACKUPARCHIVEFILE.tar.bz2"
    rm "$BACKUPARCHIVEFILE.tar"
    rm "$BACKUPARCHIVEFILE.tar.bz2"

    echo Finding and updating your archove of save states and SRAM files...
    for saveStateFile in /home/pi/RetroPie/roms/*/*.state*; do
        echo "Archiving saveStateFile $saveStateFile..."
        tar --append --file="$BACKUPARCHIVEFILE.tar" "$saveStateFile"
    done

    for SRAMFile in /home/pi/RetroPie/roms/*/*.srm; do
        echo "Archiving SRAMFile $SRAMFile..."
        tar --append --file="$BACKUPARCHIVEFILE.tar" "$SRAMFile"
    done

    echo Backing up any Dreamcast VMUs and controller configs you may have...
    for DcDataFile in /home/pi/.reicast/*; do
        echo "Archiving DcDataFile $DcDataFile..."
        tar --append --file="$BACKUPARCHIVEFILE.tar" "$DcDataFile"
    done

#TODO: Handle Dreamcast VMU cloud backups as they are not in the same folder structure
#    for DreamcastVmuFile in /opt/retropie/emulators/reicast/vmu*.bin; do
#        echo "Archiving Dreamcast VMU file $DreamcastVmuFile..."
#        tar --append --file="$BACKUPARCHIVEFILE.tar" "$DreamcastVmuFile"
#    done

    echo "Compressing your save file $BACKUPARCHIVEFILE.tar to $BACKUPARCHIVEFILE.tar.bz2..."
    compressBz2.sh "$BACKUPARCHIVEFILE.tar"
}

function ask() {
    echo -e -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function confirmRequiredDiskSpaceMB() {
    echo "Function confirmRequiredDiskSpaceMB(), parameters:"
    echo "1: RequiredDiskSpaceInMB: $1"
    required_MB=$1
    echo "2: Optional location to check space on: $2"
    if [ -z "$2" ]
    then
        rootdir="/opt/retropie"
        echo "Optional location to check space on, defaulting to $rootdir"
    else
        rootdir="$2"
    fi
    local rootdirExists=0
    if [[ ! -d "$rootdir" ]]; then
        rootdirExists=1
        mkdir -p $rootdir
    fi
    local __avail=$(df -P $rootdir | tail -n1 | awk '{print $4}')
    if [[ $rootdirExists -eq 1 ]]; then
        rmdir $rootdir
    fi

    available_MB=$((__avail/1024))

    if [[ "$required_MB" -le "$available_MB" ]] || ask "Minimum recommended disk space ($required_MB MB) not available. Try 'sudo raspi-config' to resize partition to full size if you have not yet done so. Only $available_MB MB available at $rootdir continue anyway?"; then
        return 0;
    else
        exit 0;
    fi
}

function generateControllerOverlay() {
    echo "Function generateControllerOverlay() called with parameters:"
    echo "1: Output file location: $1"
    if [ -z "$1" ]
    then
        outputImageFile="/home/pi/splashscreenwithcontrolsandversion.png"
    else
        outputImageFile="$1"
    fi

    echo "2: Controller Map text file location: $2"
    if [ -z "$2" ]
    then
        controlMapFile="/home/pi/primestationone/reference/txt/controlsMappingOverlay.txt"
    else
        controlMapFile="$2"
    fi
    controlsMappingOverlay=$(cat "$controlMapFile")
    controlsMappingTextColor=$(cat /home/pi/primestationone/reference/txt/controlsMappingTextColor.txt)

    echo "3: Right text overlay text file location: $3"
    if [ -z "$3" ]
    then
        rightTextFile="/home/pi/primestationone/reference/txt/listOfLibRetroCores.txt"
    else
        rightTextFile="$3"
    fi
    listOfLibRetroCores=$(cat "$rightTextFile")
    colorOfLibRetroCores=$(cat /home/pi/primestationone/reference/txt/listOfLibRetroCoresColor.txt)

    primestationVersion=$(cat /home/pi/primestationone/reference/txt/version.txt)
    primestationVerColor=$(cat /home/pi/primestationone/reference/txt/vercolor.txt)
    keysToQuitEmusList=$(cat /home/pi/primestationone/reference/txt/keysToQuitEmus.txt)
    colorKeysToQuitEmus=$(cat /home/pi/primestationone/reference/txt/keysToQuitEmusColor.txt)
    echo "PrimeStation One $primestationVersion updating splashscreen version text overlay with $primestationVersion in color $primestationVerColor..."
    echo "...and a $controlsMappingTextColor controlsMappingOverlay: "
    echo "$controlsMappingOverlay"
    echo "...and a $colorOfLibRetroCores listOfLibRetroCores: "
    echo "$listOfLibRetroCores"
    echo "...and a $colorKeysToQuitEmus keysToQuitEmusList: "
    echo "$keysToQuitEmusList"
    echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
    echo "......"
    convert -font courier-bold -pointsize 44 -fill "$primestationVerColor" -draw "text 1600,45 \"$primestationVersion\"" -pointsize 32 -fill "$controlsMappingTextColor" -draw "text 12,260 \"$controlsMappingOverlay\"" -pointsize 30 -fill "$colorOfLibRetroCores" -draw "text 1560,260 \"$listOfLibRetroCores\"" -pointsize 20 -fill "$colorKeysToQuitEmus" -draw "text 810,245 \"$keysToQuitEmusList\"" /home/pi/splashscreen.png "$outputImageFile"
    echo "Complete, if you didn't just see any errors."
}

function addLineToEndOfFileIfNOtExist() {
    LINE="$1"
    FILE="$2"
    if [ -z "$2" ]
    then
        echo "This function requires 2 parameters: LINE and FILE"
        echo "...if LINE does not exist in FILE, insert LINE at end of FILE."
    else
        echo "If $LINE does not exist in $FILE, inserting $LINE at end of $FILE..."
        grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
    fi
}
