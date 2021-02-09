
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

EEG=pop_chanedit(EEG, 'lookup','/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_eegfiltnew(EEG, 1, 80, 1690, 0, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = pop_eegfiltnew(EEG, 55, 65, 846, 1, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');
EEG = eeg_checkset( EEG );


EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '2'  }, [-1  5], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );

%----------------------------------------------------------------------

index = sprintf('%d',c-2)
savename = strcat ('Incentive_cue_',index,'_SE1.set')
events = eeg_eventtable(EEG, 'exportFile', savename)

EEG = pop_saveset( EEG, 'filename',savename,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

close all
clear all

end
