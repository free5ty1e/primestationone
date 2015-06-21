#!/bin/bash
echo Mass renaming all roms and saves to replace square brackets and parenthases with underscores so EmulationStation displays them in their entirety...
pushd ~/RetroPie/roms
for f in * **/*; do mv "$f" "`echo $f | sed s/[/_/`"; done
for f in * **/*; do mv "$f" "`echo $f | sed s/]/_/`"; done
for f in * **/*; do mv "$f" "`echo $f | sed s/(/_/`"; done
for f in * **/*; do mv "$f" "`echo $f | sed s/)/_/`"; done
popd
