eeglab

for c=4:2:16
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/Fibro/Substudy/time_freq')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/Fibro/Substudy/time_freq');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


for channel=1:64
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, channel, [-1000  1500], [3         0.5] , 'topovec', channel, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', EEG.chanlocs(channel).labels, 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 2048);
str = sprintf('%.0f',channel)
filename=strcat(eeg_dir(c).name,'_',str,'.png')
saveas(gcf,filename)
end

end

close all
clear all
