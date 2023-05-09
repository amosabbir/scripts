% Place this file in eeglab folder
% Go to eeglab folder
% nohup matlab -r test > outfile.txt < /dev/null &
% /rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b

ICAnumber = zeros(40,1);
ICAnumber(1,1) = 30;
ICAnumber(2,1) = 25;
ICAnumber(3,1) = 29;
ICAnumber(4,1) = 25;
ICAnumber(5,1) = 28;
ICAnumber(6,1) = 26;
ICAnumber(7,1) = 28;
ICAnumber(8,1) = 30;
ICAnumber(9,1) = 30;
ICAnumber(10,1) = 29;
ICAnumber(11,1) = 27;
ICAnumber(12,1) = 30;
ICAnumber(13,1) = 27;
ICAnumber(14,1) = 30;
ICAnumber(15,1) = 28;
ICAnumber(16,1) = 30;
ICAnumber(17,1) = 26;
ICAnumber(18,1) = 25;
ICAnumber(19,1) = 27;
ICAnumber(20,1) = 28;
ICAnumber(21,1) = 22;
ICAnumber(22,1) = 28;
ICAnumber(23,1) = 26;
ICAnumber(24,1) = 22;
ICAnumber(25,1) = 28;
ICAnumber(26,1) = 28;
ICAnumber(27,1) = 25;
ICAnumber(28,1) = 28;
ICAnumber(29,1) = 28;
ICAnumber(30,1) = 27;
ICAnumber(31,1) = 30;
ICAnumber(32,1) = 28;
ICAnumber(33,1) = 26;
ICAnumber(34,1) = 25;
ICAnumber(35,1) = 27;
ICAnumber(36,1) = 26;
ICAnumber(37,1) = 28;
ICAnumber(38,1) = 30;
ICAnumber(39,1) = 23;
ICAnumber(40,1) = 30;




%Eyes open
for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/PP_0');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/PP_0');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

%Average reference
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 

%Epoch and remove baseline
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '44'  }, [0  4], 'newname', 'pruned with ICA epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [0  3998]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

%ICA
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',ICAnumber(a,1),'chanind',1:30,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/PP_ICA_EO');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end





%Eyes closed
for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/PP_0');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/PP_0');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

%Average reference
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 

%Epoch and remove baseline
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '33'  }, [0  4], 'newname', 'pruned with ICA epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [0  3998]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

%ICA
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',ICAnumber(a,1),'chanind',1:30,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/PP_ICA_EC');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end


