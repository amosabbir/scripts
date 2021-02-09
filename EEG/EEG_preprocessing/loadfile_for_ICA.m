
for c =4:2:154
addpath ('/rri_disks/artemis/meltzer_lab/CANBIND/Resting_State_EEG_files/')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;

concat=strcat('ICA_',N);
file_name = sprintf(concat);
%end file name saving ---------------------------------------------------------------

%----------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%Re-refernce to average

EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
eeglab redraw

%---------


EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',64,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


%save
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%close
clear
close all

end
