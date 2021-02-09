c=69

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;


%--------------------------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA_after/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%if needed
EEG.icaact = (EEG.icaweights*EEG.icasphere)*EEG.data(EEG.icachansind,:);
eeglab redraw

%--------------------------------------------------------------------
pv = zeros(64,1)

for d=1:64
pvaf=eeg_pvaf(EEG,[d]);
pv(d,:) = pvaf;
end

allOneString = sprintf('%.0f,' , transpose(pv));
allOneString = allOneString(1:end-1);% strip final comma
allOneString
eeglab redraw
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
