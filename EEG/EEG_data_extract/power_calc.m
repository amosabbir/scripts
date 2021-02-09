for c =4:2:154
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
addpath ('/rri_disks/artemis/meltzer_lab/CANBIND/New_post_Apr')
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA')

%file naming and csv file ---------------------------------------------------------------
%id name
N=eeg_dir(c).name;
whereis_ =strfind(N,'_');
id=N(whereis_(2)-4:whereis_(2)-1);


%set eyes name
if  ~isempty(strfind(N,'EO'))==1
	id3= '1';
else if ~isempty(strfind(N,'EC'))==1
	id3= '2';
	end
end

%set session name
if  ~isempty(strfind(N,'SE1'))==1
	id4= '1';
else if ~isempty(strfind(N,'SE2'))==1
	id4= '2';
	end
end

id2 = str2double(regexp(id,'\d*','match'))
id3 = str2double(regexp(id3,'\d*','match'))
id4 = str2double(regexp(id4,'\d*','match'))
%-------------------------------------------------------------------------


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/processed_RS2_ICA');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );




%channel indices
F3=5;
F4=40;
C3=13;
C4=50;
P3=21;
P4=58;
O1=27;
O2=64;

channel_array = [F3,F4,C3,C4,P3,P4,O1,O2];

%PWELCH ------------------------------------------------
fs = 512;
totalp = zeros(76, 129);

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
all_data = zeros(76, 9);

for chan = 1:76

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

delta = mean(Power_array(1:3,2));
theta = mean(Power_array(3:5,2));
alpha = mean(Power_array(5:7,2));
beta = mean(Power_array(8:16,2));
gamma = mean(Power_array(16:129,2));
total_channel = sum(Power_array(1:129,2));

power_values = [id2,id3,id4,delta,theta,alpha,beta,gamma,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(channel_array,:);


%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('Baseline_EC.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end
