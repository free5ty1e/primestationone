#!/bin/bash

UAEPATH=/opt/retropie/emulators/uae4all
rm -fr $UAEPATH/df*.adf
case $1 in
*_disk1.adf|*_disk1.ADF)
ln -s $1 $UAEPATH/df0.adf
ln -s ${1:0:-5}2.adf $UAEPATH/df1.adf
;;
*_disk2.adf|*_disk2.ADF)
ln -s $1 $UAEPATH/df1.adf
ln -s ${1:0:-5}1.adf $UAEPATH/df0.adf
;;
*)
ln -s $1 $UAEPATH/df0.adf
;;
esac
pushd $UAEPATH
./uae4all
popd
