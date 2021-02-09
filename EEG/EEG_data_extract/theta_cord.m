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
Fp1=1;
Fp2=34;
Fz=33;

channel_array = [Fp1,Fp2,Fz];

%PWELCH ------------------------------------------------
disp('pwelch start')
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
disp('pwelch end')
%End PWELCH ------------------------------------------------


%Generate data matrix general ----------------------------------------
disp('generate data start')
all_data = zeros(76, 6);
all_data_cordance = zeros (76,7);

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
relative_theta = theta/total_channel;


power_values = [id2,id3,id4,theta,total_channel,relative_theta];

all_data(chan,:) = power_values;


end

data_for_stats = all_data(channel_array,:);



%Theta cordance ---------------------
for chan = 1:76

%absolute calculations
absolute_theta_max = max(all_data(:,4));
absolute_theta_vector = (ones(76,1)*absolute_theta_max);
absolute_norm = all_data(chan,4)/absolute_theta_max;


%relative calculations
relative_theta_max = max(all_data(:,6));
relative_theta_vector = (ones(76,1)*relative_theta_max);
relative_norm = all_data(chan,6)/relative_theta_max;

%theta cordance
a_norm_half = absolute_norm - 0.5;
r_norm_half = relative_norm - 0.5;
cordance = abs(a_norm_half) + abs(r_norm_half);


all_data_ = [absolute_theta_max,absolute_norm,relative_theta_max,relative_norm,a_norm_half,r_norm_half,cordance];
all_data_cordance(chan,:) = all_data_;

end

data_for_stats_cordance = all_data_cordance(channel_array,:);
%END----------------

data_for_stats_final = [data_for_stats data_for_stats_cordance];
%title columns: id2,id3,id4,theta,total_channel,relative_theta,absolute_theta_max,absolute_norm,relative_theta_max,relative_norm,a_norm_half,r_norm_half,cordance
disp('generate data end')
%END Generate data file ----------------------------------------

disp('before_dlm')
dlmwrite('Theta_cordance.csv',data_for_stats_final,'-append')
disp('after_dlm')
disp(c)

clear all
close all
end
