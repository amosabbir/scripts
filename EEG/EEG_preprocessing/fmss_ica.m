% Place this file in eeglab folder
% Go to eeglab folder
% nohup matlab -r COVID_preprocessing_ICA_new > outfile.txt < /dev/null &
% /rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b

%new Jun21
% matlab -r COVID_preprocessing_ICA_new > outfile.txt < /dev/null &

addpath('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')


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





%Eyes closed
for a=1:41
c=2+2*a
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/FMSS/FMSS_PP0_ref_filt');
N=eeg_dir(c).name;
concat=strcat(N,'_ICA');
file_name = sprintf(concat);



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/FMSS/FMSS_PP0_ref_filt');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%ICA
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',ICAnumber(a,1),'chanind',1:64,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/FMSS/FMSS_ref_filt_ICA');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end


