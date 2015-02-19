#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f elephant Installing first run files...
echo Installing first run files...
installFirstRunFiles.sh

echo =====================> Installing corrected blank gamelist.xml files...
installBlankGamelists.sh

autoStartEmulationstationEnforce.sh

retroPieNukeAndCheckoutFresh.sh
