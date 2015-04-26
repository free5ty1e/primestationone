#!/bin/bash

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


function reset_permissions_bios_and_roms() {
    echo Resetting permissions on roms and BIOS folders...
    sudo chmod -R 777 ~/RetroPie
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
    echo Title Backtitle InputBoxTitle optionalIsPassword optionalHeight optionalWidth
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
        echo "No height supplied, using autoheight 0"
        height=0
    else
        height=$5
    fi

    if [ -z "$6" ]
    then
        echo "No width supplied, using autowidth 0"
        width=0
    else
        width=$6
    fi

    if [ $isPassword -eq 1 ]
    then
        dialog --title "$1" --backtitle "$2" --passwordbox "$3" $height $width 2>/tmp/input.$$
    else
        dialog --title "$1" --backtitle "$2" --inputbox "$3" $height $width 2>/tmp/input.$$
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

function download_install_mega_archive_from_cloud_storage_on_the_fly() {
    echo "Function download_install_mega_archive_from_cloud_storage_on_the_fly() with parameters:"
    echo "Mega module / archive name: $1"
    archiveName="$1"
    echo "Install location: $2"
    installLocation="$2"
    echo "Archive size in bytes: $3"
    archiveSize="$3"
    echo "Mega file location: $4"
    megaLink="$4"

    if [ -z "$5" ]
    then
        echo "No stripComponentCount supplied, defaulting to stripComponentCount 0"
        stripComponentCount=0
    else
        stripComponentCount=$5
    fi
    echo "Stripping Component Count: $stripComponentCount"

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

