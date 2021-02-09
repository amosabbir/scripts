

for c =3:78
addpath ('/rri_disks/artemis/meltzer_lab/CANBIND/Resting_State_EEG_files/')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Resting_State_EEG_files/')

%file name saving ---------------------------------------------------------------
%id name for saving
N=eeg_dir(c).name;
whereis_ =strfind(N,'_');
id=N(whereis_(2)+1:whereis_(3)-1);

%set eyes name
if  ~isempty(strfind(N,'eo'))==1
	A= 'EO';
else if ~isempty(strfind(N,'ec'))==1
	A= 'EC';
	end
end

%set session name
if  ~isempty(strfind(N,'01_SE01'))==1
	B= 'SE1';
else if ~isempty(strfind(N,'02_SE01'))==1
	B= 'SE2';
	end
end

concat=strcat(id,'_RS_',A,'_',B,'_');
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

List_of_channels={EEG.chanlocs(:).labels}

if ismember('EXG1', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG1'});
	%delete_channel1 = 'EXG1'
	%del_cat = {delete_channel1}
end

if ismember('EXG2', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG2'});
	%delete_channel2 = 'EXG2'
	%del_cat = strcat(del_cat, {' '}, delete_channel2)
end

if ismember('EXG3', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG3'});
	%delete_channel3 = 'EXG3'
	%del_cat = strcat(del_cat, {' '}, delete_channel3)
end

if ismember('EXG4', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG4'});
	%delete_channel4 = 'EXG4'
	%del_cat = strcat(del_cat, {' '}, delete_channel4)
end

if ismember('EXG5', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG5'});
	%delete_channel5 = 'EXG5'
	%del_cat = strcat(del_cat, {' '}, delete_channel5)
end

if ismember('EXG6', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG6'});
	%delete_channel6 = 'EXG6'
	%del_cat = strcat(del_cat, {' '}, delete_channel6)
end

if ismember('EXG7', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG7'});
	%delete_channel7 = 'EXG7'
	%del_cat = strcat(del_cat, {' '}, delete_channel7)
end

if ismember('EXG8', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG8'});
	%delete_channel8 = 'EXG8'
	%del_cat = strcat(del_cat, {' '}, delete_channel8)
end
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw
%END deleting code------------


%Filtering-----
EEG = pop_eegfiltnew(EEG, 1, 80, 1690, 0, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'overwrite','on','gui','off');
EEG = pop_eegfiltnew(EEG, 55, 65, 846, 1, [], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'overwrite','on','gui','off');
%END-----


%Epoching-----------------------


%Creating the first event if none
EEG.event(1).type='1';
EEG.event(1).latency=2000;
EEG.event(1).urevent=1;


for index = 1 : 239
% Add events relative to existing events
EEG.event(end+1) = EEG.event(index); % Add event to end of event list
% Specifying the event latency to be 1 sec after the referent event (in real data points)
EEG.event(end).latency = EEG.event(1).latency + 2*(index)*EEG.srate;
EEG.event(end).type = 'CreateEvent'; '% Make the type of the new event '
end;

EEG = eeg_checkset(EEG, 'eventconsistency'); % Check all events for consistency
%[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw % Redraw the main eeglab window

EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'CreateEvent'  }, [-1         1], 'newname', 'Eyes Open CANBIND referenced epoch epochs', 'epochinfo', 'yes');
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','Eyes Open CANBIND referenced epochs','gui','off');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-999 999]);
%ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off');
eeglab redraw
%END Epoching-----------------------


%Interpolate now--------------------

[RejectVar, RejectVar.reject.indelec] = pop_rejchan(EEG, 'elec',[1:76] ,'threshold',5,'norm','on','measure','kurt');

EEG.reject.indelec = RejectVar.reject.indelec;

EEG = eeg_interp(EEG,EEG.reject.indelec)

EEG.reject.indelec = RejectVar.reject.indelec;

%----------------------------------


%Re-refernce to average

%EEG = eeg_checkset( EEG );
%EEG = pop_reref( EEG, []);
%eeglab redraw

%---------


%EEG = eeg_checkset( EEG );
%EEG = pop_runica(EEG, 'pca',64,'interupt','on');
%[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


%save
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%close
clear
close all

end
