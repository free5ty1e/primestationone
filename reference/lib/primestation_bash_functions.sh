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

    message="Downloading and installing $archiveName mega module on-the-fly with no archive or temp files..."
    echo "$message"
    cowsay -f flaming-sheep "$message"

    pushd "$installLocation"

    echo Downloading archive from Mega and decompressing it on the fly...
    megadl --no-progress --path=- "$megaLink" | pv -p -s "$archiveSize" | tar xvj

    popd
    echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...

}


function reset_permissions_bios_and_roms() {
    echo Resetting permissions on roms and BIOS folders...
    sudo chmod -R 777 ~/RetroPie
}

function rsync_with_progress() {
    RSYNC="ionice -c3 rsync"
    # don't use --progress
    RSYNC_ARGS="-xvrltD --delete --stats --human-readable
    SOURCES="$1"
    TARGET="$2"

    #echo "Executing dry-run to see how many files must be transferred..."
    #TODO=$(${RSYNC} --dry-run ${RSYNC_ARGS} ${SOURCES} ${TARGET}|grep "^Number of files transferred"|awk '{print $5}')
    TODO=$(find ${SOURCES} | wc -l)
    echo "$TODO files counted to sync..."

    ${RSYNC} ${RSYNC_ARGS} ${SOURCES} ${TARGET} | pv -l -e -p -s "$TODO"
}