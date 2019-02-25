#!/bin/bash
pname=${1?missing parameters: pname}
folder=${2?missing parameters: folder}
rootf=${3?missing parameters: rootf}
out=${4?missing parameters: out}
if [ "x$TFPHOME" = "x" ]; then
  echo "TFPHOME must be set to the directory containing the TFP files."
  exit 1
fi
#cd $TFPHOME
if [ ! -d $folder -a ! -f $folder ]; then
	echo "$folder is invalid";
	exit 1
fi
$TFPHOME/tr.sh $pname $folder #translates FDR4 to FDR2
$FDRHOME/bin/fdr2 batch $folder/out/$rootf #generates prism file
$TFPHOME/tpp $folder/out/*.pm $folder #gdb --args $TFPHOME/tpp $folder/out/*.pm $folder #
mv $folder/model_out.pm $out
rm -r $folder/out #comentar para depurar
if [ -f $out ]; then
	echo "Translation complete!";
else
	echo "An error occured. Try again or contact the support";
fi