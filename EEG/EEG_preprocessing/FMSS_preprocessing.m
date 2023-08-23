%/rri_disks/artemis/meltzer_lab/Fibro/SubStudy/raw_files
%/rri_disks/artemis/meltzer_lab/Fibro/SubStudy
% nohup matlab -r FMSS_preprocessing > outfile.txt < /dev/null &


for c=3:42
%c=2+2*a

addpath ('/rri_disks/artemis/meltzer_lab/Fibro/SubStudy/raw_files')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/Fibro/SubStudy/raw_files')

%file name saving ---------------------------------------------------------------
%id name for saving
N=eeg_dir(c).name;
whereis_ =strfind(N,'_');
id=N(whereis_(1)-2:whereis_(2)+5);


concat=strcat(id,'_filt_ref');
file_name = sprintf('%s%d.set', concat,c);
%end file name saving ---------------------------------------------------------------

%open
eeglab
EEG = pop_biosig(eeg_dir(c).name);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');


%EEG Pre-processing----------------------------------------------------------------

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',file_name,'gui','off');
EEG=pop_chanedit(EEG, 'lookup','/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );


%deleting code------------
%List_of_channels={EEG.chanlocs(:).labels}
%if ismember('CB1', List_of_channels)==1;
%	EEG = eeg_checkset( EEG );
%	EEG = pop_select( EEG,'nochannel',{'CB1'});
%	%delete_channel1 = 'CB1'
%	%del_cat = {delete_channel1}
%end


[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw
%END deleting code------------


%Filtering-----
EEG = pop_eegfiltnew(EEG, 55, 65, 826, 1, [], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
EEG = pop_eegfiltnew(EEG, [], 0.1, 16500, true, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'gui','off'); 
EEG = eeg_checkset( EEG );
%END-----


%Re-refernce to average

EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [], 'exclude', [65:76]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 

%---------


%save
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/eugenia/meltzer_lab/FMSS/PP_0');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%close
clear
close all

end
