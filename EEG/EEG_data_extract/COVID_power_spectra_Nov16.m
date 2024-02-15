%Eyes open, before------------------------------------------------------------  

for a=1:16
c=2+2*a

addpath ('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/Before')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/Before')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 1; %Eyes closed 2 Eyes open 1
id4 = 1; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/Before');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('Packet Counter', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'Packet Counter'});
end

if ismember('ACC30', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC30'});
end

if ismember('ACC31', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC31'});
end

if ismember('ACC32', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC32'});
end



%PWELCH ------------------------------------------------
fs = 500;
totalp = zeros(30, 257);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end

%End PWELCH ------------------------------------------------


%Generate data file ----------------------------------------
all_data = zeros(29, 261);

for chan = 1:30

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

total_channel = sum(Power_array(1:256,2));

power_values = [id2,id3,id4, (totalp(chan,:))./total_channel,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(:,:);


%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EO_before_spectra_relative.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end


%Eyes open, after--------------------------------------------------------------------------------

for a=1:17
c=2+2*a

addpath ('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/After')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/After')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 1; %Eyes closed 2 Eyes open 1
id4 = 2; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO_del/After');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('Packet Counter', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'Packet Counter'});
end

if ismember('ACC30', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC30'});
end

if ismember('ACC31', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC31'});
end

if ismember('ACC32', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC32'});
end



%PWELCH ------------------------------------------------
fs = 500;
totalp = zeros(30, 257);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end

%End PWELCH ------------------------------------------------


%Generate data file ----------------------------------------
all_data = zeros(29, 261);

for chan = 1:30

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

total_channel = sum(Power_array(1:256,2));

power_values = [id2,id3,id4, (totalp(chan,:))./total_channel,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(:,:);



%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EO_after_spectra_relative.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end



%Eyes closed, before ------------------------------------------------

for a=1:15
c=2+2*a

addpath ('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/Before')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/Before')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 2; %Eyes closed 2 Eyes open 1
id4 = 1; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/Before');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('Packet Counter', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'Packet Counter'});
end

if ismember('ACC30', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC30'});
end

if ismember('ACC31', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC31'});
end

if ismember('ACC32', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC32'});
end



%PWELCH ------------------------------------------------
fs = 500;
totalp = zeros(30, 257);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end

%End PWELCH ------------------------------------------------


%Generate data file ----------------------------------------
all_data = zeros(29, 261);

for chan = 1:30

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

total_channel = sum(Power_array(1:256,2));

power_values = [id2,id3,id4, (totalp(chan,:))./total_channel,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(:,:);



%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EC_before_spectra_relative.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end


%Eyes closed, after ------------------------------------------------

for a=1:16
c=2+2*a

addpath ('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/After')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/After')
N=eeg_dir(c).name;
id2 = str2num(N(5:6)); %COVID ID
id3 = 2; %Eyes closed 2 Eyes open 1
id4 = 2; %Before 1 After 2



[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del/After');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('Packet Counter', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'Packet Counter'});
end

if ismember('ACC30', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC30'});
end

if ismember('ACC31', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC31'});
end

if ismember('ACC32', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'ACC32'});
end



%PWELCH ------------------------------------------------
fs = 500;
totalp = zeros(30, 257);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end

%End PWELCH ------------------------------------------------


%Generate data file ----------------------------------------
all_data = zeros(29, 261);

for chan = 1:30

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

total_channel = sum(Power_array(1:256,2));

power_values = [id2,id3,id4, (totalp(chan,:))./total_channel,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(:,:);



%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EC_before_spectra_relative.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end