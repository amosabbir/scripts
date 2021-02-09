#!/bin/bash
# Basic while loop
c=1
while [ $c -le 20 ]
do

myArray=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20")
mystring=\'$c\'
#echo ${myArray[c]}

part1=/rri_disks/artemis/meltzer_lab/CANBIND/EEG_files_from_Spred/00
part2=/CBN07_TWH_00
part3=_02_SE01_EEG/scans/3_EEG_anhedonia/EEG/CBN07_TWH_00
part4=_02_SE01_EEG_anhedonia.bdf
totalpart="${part1}${myArray[c]}${part2}${myArray[c]}${part3}${myArray[c]}${part4} "

dest=/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia
cp ${totalpart} ${dest}

((c++))
done
echo All done
