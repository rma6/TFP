#!/bin/bash
pname="$1"
folder="$2"
find $folder -type f > $folder/temp.txt
find $folder -type d > $folder/dirs.txt
sed -i -e "s+$folder+$folder/out/+g" $folder/dirs.txt
#$TFPHOME/filter $folder
xargs mkdir -p < $folder/dirs.txt
$TFPHOME/tr $pname $folder #gdb --args $TFPHOME/tr $pname $folder #
rm $folder/temp.txt
rm $folder/dirs.txt