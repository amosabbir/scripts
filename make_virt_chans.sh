
################################################
##PART 1 - LAST WORD / N400
set workdir = /home/student12/data
set ds = ${workdir}/proc/last_word_grand.ds
set win = win_last_word_-1_4
set targetfilepath = ${workdir}/anat/
set targetfilename = targets116
cp ${targetfilepath}/${targetfilename} ${ds}/SAM
set cov = ${win},0-100Hz
set newdsname = ${workdir}/proc/virt116_vis_last_word

echo '' > ${workdir}/proc/samlogvirt.txt

cp /home/jed/data/jedcode/N4P6megcode/samparam/${win} ${ds}/SAM/
SAMcov -v -m $win -r $ds -f "0 100" >> ${workdir}/proc/samlogvirt.txt

SAMsrc -r $ds -c $cov -t $targetfilename -W 0 -Z >> ${workdir}/proc/samlogvirt.txt

newDs2 -marker last_word -time -1 4 -band 0 100 \
     -includeSAM ${cov},${targetfilename}.wts -excludeMEG $ds $newdsname

##Then import into eeglab (import data from ctf folder (MEG), choose channels 52:167, and save as virt116_vis_last_word.set, delete the virtual .ds dataset


################################################
##PART 2 - CRIT WORD / P600

set workdir = /home/student12/data
set ds = ${workdir}/proc/crit_word_grand.ds
set win = win_critical_begin_-1_4
set targetfilepath = ${workdir}/anat/
set targetfilename = targets116
cp ${targetfilepath}/${targetfilename} ${ds}/SAM
set cov = ${win},0-100Hz
set newdsname = ${workdir}/proc/virt116_vis_crit_word


cp /home/jed/data/jedcode/N4P6megcode/samparam/${win} ${ds}/SAM/
SAMcov -v -m $win -r $ds -f "0 100" >> ${workdir}/proc/samlogvirt.txt

SAMsrc -r $ds -c $cov -t $targetfilename -W 0 -Z >> ${workdir}/proc/samlogvirt.txt

newDs2 -marker critical_begin -time -1 4 -band 0 100 \
     -includeSAM ${cov},${targetfilename}.wts -excludeMEG $ds $newdsname

##Then import into eeglab (import data from ctf folder (MEG), choose channels 52:167, and save as virt116_vis_crit_word.set, delete the virtual .ds dataset
