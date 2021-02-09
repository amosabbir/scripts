



for c =11:78
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
EEG = pop_reref( EEG, []);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Eyes Open CANBIND referenced','gui','off'); 
eeglab redraw

EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [], 55, 124, 0, [], 1);
eeglab redraw

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


%Creating the first event if none
EEG.event(1).type='1';
EEG.event(1).latency=100;
EEG.event(1).urevent=1;
%-------------------------------



for index = 1 : 480 
% Add events relative to existing events
EEG.event(end+1) = EEG.event(index); % Add event to end of event list
% Specifying the event latency to be 1 sec after the referent event (in real data points) 
EEG.event(end).latency = EEG.event(1).latency + 1*(index)*EEG.srate; 
EEG.event(end).type = 'CreateEvent'; '% Make the type of the new event '
end;
 
EEG = eeg_checkset(EEG, 'eventconsistency'); % Check all events for consistency
%[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw % Redraw the main eeglab window

EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'CreateEvent'  }, [-0.5         0.5], 'newname', 'Eyes Open CANBIND referenced epoch epochs', 'epochinfo', 'yes');
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','Eyes Open CANBIND referenced epochs','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-500 498.0469]);
%ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 

EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);


fs = 512;


totalp = zeros(84, 129);


for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welch's method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs

disp(channel);
totalp(channel,:) = mpow;

end


%plot(freqs, log10(totalp(:,:)))
%
axis([0 50 0 3])

%ICA
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',64,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

eeglab redraw
%END EEG Pre-processing----------------------------------------------------------------

%save
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',file_name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS/');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%close
clear
close all

end


