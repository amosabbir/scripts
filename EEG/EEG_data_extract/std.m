%after epoch deletion

for a=1:19
c=2+2*a

addpath ('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/Before')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/Before')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 2; %Eyes closed 2 Eyes open 1
id4 = 1; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/Before');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );




std_data = zeros(29,4)

for chan = 1:29

	std_value = std(EEG.data(chan,:));
	data_values = [id2,id3,id4,std_value];
	std_data(chan,:) = data_values;
end	


data_for_stats = std_data(:,:);


%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EC_before_std.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end



%after epoch deletion

for a=1:19
c=2+2*a

addpath ('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/After')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/After')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 2; %Eyes closed 2 Eyes open 1
id4 = 2; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/After');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );




std_data = zeros(29,4)

for chan = 1:29

	std_value = std(EEG.data(chan,:));
	data_values = [id2,id3,id4,std_value];
	std_data(chan,:) = data_values;
end	


data_for_stats = std_data(:,:);


%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('after_dlm')
dlmwrite('EC_after_stats_std.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end





%after epoch deletion

for a=1:19
c=2+2*a

addpath ('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/After')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/After')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 1; %Eyes closed 2 Eyes open 1
id4 = 2; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/After');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );



std_data = zeros(29,4)

for chan = 1:29

	std_value = std(EEG.data(chan,:));
	data_values = [id2,id3,id4,std_value];
	std_data(chan,:) = data_values;
end	


data_for_stats = std_data(:,:);

%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('after_dlm')
dlmwrite('EO_after_stats_std.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end




%before epoch deletion

for a=1:19
c=2+2*a

addpath ('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/Before')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/Before')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 1; %Eyes closed 2 Eyes open 1
id4 = 1; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_eo_del/Before');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );



std_data = zeros(29,4)

for chan = 1:29

	std_value = std(EEG.data(chan,:));
	data_values = [id2,id3,id4,std_value];
	std_data(chan,:) = data_values;
end	


data_for_stats = std_data(:,:);

%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EO_before_stats_std.csv',data_for_stats,'-append')
disp('before_dlm')
disp(c)

clear all
close all
end


