eeglab

for c=21:2:35
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/Fibro/Substudy')

%file name saving --------------------------------------------------------------
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/Fibro/Substudy');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%PSD of ERP---------------------------------------------------------------------

ERP=mean(EEG.data,3);

fs = 2048;
totalp = zeros(64, 101);
for channel=1:size(ERP,1) %dimension 1 is channel
powdata= pwelch(detrend(ERP(channel,:)),[],[],[0:100],fs);
[junk, freqs] = pwelch(detrend(ERP(channel,:)),[],[],[0:100],fs);
%just to save thfree frequencies calculated, as freqs
mpow = powdata; %dimension 2 is epochs
disp(channel);
totalp(channel,:) = mpow;
end

save('test.mat','totalp');

PSD = extractAfter(eeg_dir(c).name,23);
PSD = strcat(PSD,"totalp.mat");
save(PSD,'totalp');

close all
clear all

end


load()




for channel=1:64
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, channel, [-1000  1500], [3         0.5] , 'topovec', channel, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', EEG.chanlocs(channel).labels, 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 2048);
str = sprintf('%.0f',channel)
filename=strcat(eeg_dir(c).name,'_',str,'.png')
saveas(gcf,filename)
end





%PSD of ERP----------------------------------------------------

fs = 2048;
totalp = zeros(64, 101);
for channel=1:size(ERP,1) %dimension 1 is channel
powdata= pwelch(detrend(ERP(channel,:)),[],[],[0:100],fs);
[junk, freqs] = pwelch(detrend(ERP(channel,:)),[],[],[0:100],fs);
%just to save thfree frequencies calculated, as freqs
mpow = powdata; %dimension 2 is epochs
disp(channel);
totalp(channel,:) = mpow;
end



for channel=1:64
plot(freqs(1:50),totalp(channel,1:50))
disp(channel);
str = sprintf('%.0f',channel)
filename=strcat('rest','_','avgICAPSD',str,'.png')
saveas(gcf,filename)
end


totalp = zeros(62, 513);


for channel=1:size(out2,1) %dimension 1 is channel


powdata= pwelch(detrend(out2(channel,:)),[],[],[],fs);


[junk, freqs] = pwelch(detrend(out2(channel,:)),[],[],[],fs);

mpow = mean(powdata,2); %dimension 2 is epochs

disp(channel);
totalp(channel,:) = mpow;

end
