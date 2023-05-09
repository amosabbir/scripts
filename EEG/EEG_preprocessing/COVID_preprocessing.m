

for c =3:45
addpath ('/rri_disks/artemis/meltzer_lab/COVID')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/EEG_files')

%file name saving ---------------------------------------------------------------
%id name for saving
N=eeg_dir(c).name;
whereis_ =strfind(N,'_');
id=N(1:whereis_(3)+6);


concat=strcat(id,'_ICA');
file_name = sprintf('%s%d.set', concat);
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

%if ismember('Packet Counter', List_of_channels)==1;
%	EEG = eeg_checkset( EEG );
%	EEG = pop_select( EEG,'nochannel',{'Packet Counter'});
%	%delete_channel1 = 'Packet Counter'
%	%del_cat = {delete_channel1}
%end

%if ismember('ACC30', List_of_channels)==1;
%	EEG = eeg_checkset( EEG );
%	EEG = pop_select( EEG,'nochannel',{'ACC30'});
%	%delete_channel2 = 'ACC30'
%	%del_cat = strcat(del_cat, {' '}, delete_channel2)
%end

%if ismember('ACC31', List_of_channels)==1;
%	EEG = eeg_checkset( EEG );
%	EEG = pop_select( EEG,'nochannel',{'ACC31'});
	%delete_channel3 = 'ACC31'
	%del_cat = strcat(del_cat, {' '}, delete_channel3)
%end

%if ismember('ACC32', List_of_channels)==1;
%	EEG = eeg_checkset( EEG );
%	EEG = pop_select( EEG,'nochannel',{'ACC32'});
	%delete_channel4 = 'ACC32'
	%del_cat = strcat(del_cat, {' '}, delete_channel4)
%end



%delete channels
EEG = pop_interp(EEG, [2  23], 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );


%Filtering
EEG = pop_eegfiltnew(EEG, 55, 65, 826, 1, [], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
EEG = pop_eegfiltnew(EEG, [], 0.1, 16500, true, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'gui','off'); 
EEG = eeg_checkset( EEG );



%EEG = pop_epoch( EEG, {  '44'  }, [0  4], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%EEG = eeg_checkset( EEG );


EEG = pop_rmbase( EEG, []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);



%ICA
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',30,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);



%save
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%close
clear
close all

end
