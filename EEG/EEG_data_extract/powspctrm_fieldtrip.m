addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')
load elec64.mat

resp=[1,3,5,9,12,14,19];
tworesp=40+(resp*2);
resp=resp*2+2;
resp=[resp tworesp];


nonresp=[2,4,6,7,8,10,11,13,15,16,17,18];
twononresp=40+(nonresp*2);
nonresp=nonresp*2+2;
nonresp=[nonresp twononresp];


%-Responder Incentive SE1 -----------------------------

for c=1:7
array=[1:7];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/SE1_power');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',N,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/SE1_power');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 128);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%PWELCH ------------------------------------------------
fs = 128;
totalp = zeros(64, 129);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save the frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end
%End PWELCH ------------------------------------------------

eegdata=eeglab2fieldtrip(EEG,'preprocessing')
eegdata.elec = elec;
eegdata.dimord = 'chan_freq'
eegdata.freq = freqs
eegdata.powspctrm = totalp


Resp_pow_SE1_EC{c}=eegdata;


end



%-Non responder SE1 -----------------------------

for c=1:12
array=[1:12];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/SE1_power');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',N,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/SE1_power');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 128);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%PWELCH ------------------------------------------------
fs = 128;
totalp = zeros(64, 129);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save the frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end
%End PWELCH ------------------------------------------------

eegdata=eeglab2fieldtrip(EEG,'preprocessing')
eegdata.elec = elec;
eegdata.dimord = 'chan_freq'
eegdata.freq = freqs
eegdata.powspctrm = totalp

Nonresp_pow_SE1_EC{c}=eegdata

end


%-Responder Incentive SE2 -----------------------------

for c=1:7
array=[1:7];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/SE2_power');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',N,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/SE2_power');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 128);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%PWELCH ------------------------------------------------
fs = 128;
totalp = zeros(64, 129);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save the frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end
%End PWELCH ------------------------------------------------

eegdata=eeglab2fieldtrip(EEG,'preprocessing')
eegdata.elec = elec;
eegdata.dimord = 'chan_freq'
eegdata.freq = freqs
eegdata.powspctrm = totalp


Resp_pow_SE2_EC{c}=eegdata;


end



%-Non responder Incentive SE2 -----------------------------

for c=1:12
array=[1:12];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/SE2_power');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',N,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/SE2_power');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 128);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%PWELCH ------------------------------------------------
fs = 128;
totalp = zeros(64, 129);

for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save the frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs


totalp(channel,:) = mpow;

end
%End PWELCH ------------------------------------------------

eegdata=eeglab2fieldtrip(EEG,'preprocessing')
eegdata.elec = elec;
eegdata.dimord = 'chan_freq'
eegdata.freq = freqs
eegdata.powspctrm = totalp

Nonresp_pow_SE2_EC{c}=eegdata

end


save Power_EC Resp_pow_SE1_EC Nonresp_pow_SE1_EC Resp_pow_SE2_EC Nonresp_pow_SE2_EC
