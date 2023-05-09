%after epoch deletion

for a=1:20
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




%channel indices
Fp1=1;
Fp2=34;
Fz=33;

F3=5;
F4=40;
C3=13;
C4=50;
P3=21;
P4=58;
O1=27;
O2=64;

channel_array = [Fp1,Fp2,Fz,F3,F4,C3,C4,P3,P4,O1,O2];




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
all_data = zeros(29, 9);

for chan = 1:29

%PSD power ranges at specific channel

Power_array = [freqs, (totalp(chan,:))'];
%'

delta = mean(Power_array(1:4,2));
theta = mean(Power_array(4:7,2));
alpha = mean(Power_array(8:12,2));
beta = mean(Power_array(12:30,2));
gamma = mean(Power_array(30:60,2));
total_channel = sum(Power_array(1:256,2));

power_values = [id2,id3,id4,delta,theta,alpha,beta,gamma,total_channel];

all_data(chan,:) = power_values;

end

data_for_stats = all_data(:,:);


%chanlocs vector
%chanlocs_vector = zeros(76,1)
%for loc = 1:76
%chanlocs = (EEG.chanlocs(loc).labels);
%chanloc_vector(loc,1) = chanlocs;
%end

%END Generate data file ----------------------------------------

%Make Sure You Are in The Path!!!
disp('before_dlm')
dlmwrite('EC_before_stats.csv',data_for_stats,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end
