
for c = 3:22

addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
addpath ('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1/')

%file name saving ---------------------------------------------------------------
str1 = '/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1/'
N=eeg_dir(c).name;
loadname = strcat(str1,N)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig(loadname);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '2'  }, [0  5], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [0      4998.0469]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

index = sprintf('%d',c-2)
savename = strcat (index,'.xls')
events = eeg_eventtable(EEG, 'exportFile', savename)

close all
clear all

end
