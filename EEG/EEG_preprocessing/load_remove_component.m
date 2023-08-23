
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




c=69

eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;


%--------------------------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%if needed
EEG.icaact = (EEG.icaweights*EEG.icasphere)*EEG.data(EEG.icachansind,:);
eeglab redraw

%--------------------------------------------------------------------
%pv = zeros(64,1)
%for d=1:64
%pvaf=eeg_pvaf(EEG,[d]);
%pv(d,:) = pvaf;
%end
%allOneString = sprintf('%.0f,' , transpose(pv));
%allOneString = allOneString(1:end-1);% strip final comma
%allOneString
%eeglab redraw
%--------------------------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, a, 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

%--------------------------------------------------------------------
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA_after/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all
