channels = 1;
samples = 2;
epochs = 3;
fs = 2048;


totalp = zeros(64, 513);


for channel=1:size(EEG.data,1) %dimension 1 is channel

for trial=1:size(EEG.data,3) %dimension 3 is epochs
powdata(:,trial)= pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%power spectra with Welchs method
end

[junk, freqs] = pwelch(detrend(EEG.data(channel,:,trial)),[],[],[],fs);
%just to save thfree frequencies calculated, as freqs
mpow = mean(powdata,2); %dimension 2 is epochs

disp(channel);
totalp(channel,:) = mpow;

end

str = sprintf(%,channel)
for channel=1:32
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, channel, [-1000  1500], [3         0.5] , 'topovec', channel, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', EEG.chanlocs(channel).labels, 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 2048);
str = sprintf('%.0f',channel)
filename=strcat('vib20','_',str)
saveas(gcf,'test.png')
end


EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 7, [-1000  1500], [3         0.5] , 'topovec', 7, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F7', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 2048);


EEG.chanlocs(channel).labels


EEG.icaact = (EEG.icaweights*EEG.icasphere)*EEG.data(EEG.icachansind,:);
[itc, powbase, times, freqs, itcboot, tfdata] = pop_newtimef(EEG_TIMING_SIMUL, 1, chti, [200 800], 0, 'baseline', 0, 'freqs', 11.7, 'alpha', .05, 'plotersp', 'off');

a=EEG.icaact
[r,c] = size(a);
nlay  = 40;
out   = permute(reshape(a',[c/nlay,r,nlay]),[2,1,3]);

%'

X = EEG.icaact;
Y = permute(reshape(X, 64, 40, 4096), [1, 3, 2]);
