
for c =4:2:80
addpath ('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data')


%file name saving ---------------------------------------------------------------
%id name for saving
N=eeg_dir(c).name;
whereis_ =strfind(N,'_');
id=N(whereis_(2)+1:whereis_(3)-1);


%set session name
if  ~isempty(strfind(N,'SE1'))==1
	B= 'SE1';
else if ~isempty(strfind(N,'SE2'))==1
	B= 'SE2';
	end
end

%set eyes name
if  ~isempty(strfind(N,'Non'))==1
	A= 'NI';
else if ~isempty(strfind(N,'Incentive'))==1
	A= 'I';
	end
end

concat=strcat(A,'_',id,'_',B);
file_name = sprintf('%s.csv', concat);
%end file name saving ---------------------------------------------------------------




%----------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


events = eeg_eventtable(EEG, 'exportFile', file_name)

%close
clear
close all

end
