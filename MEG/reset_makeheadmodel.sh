cd /home/amosabbir/TestMEGdata/
rm -r *
pwd
mkdir anat
mkdir proc
mkdir raw
mkdir data
mkdir scripts

cp -r /rri_disks/artemis/meltzer_lab/SickKidsMEG/Data/MEG_Part1/ST39_MEG072_20140508_Motor.ds/ /home/amosabbir/TestMEGdata/data
cp -r /rri_disks/artemis/meltzer_lab/SickKidsMEG/Data/T1/ST39_T1.hdr /home/amosabbir/TestMEGdata/data
cp -r /rri_disks/artemis/meltzer_lab/SickKidsMEG/Data/T1/ST39_T1.img /home/amosabbir/TestMEGdata/data
cd /home/amosabbir/TestMEGdata/data
ls

3dcopy ST39_T1.hdr ST39_T1+orig
3dinfo ST39_T1+orig
