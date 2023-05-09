%Component deletion----------------------------------------

emptycell = cell(40,2)

for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2');
N=eeg_dir(c).name;
emptycell{a,1} = N;

end

emptycell{1,2} = [1 2 3 4 5 6 9 13 15 20 21 23 30]
emptycell{2,2} = [1 2 4 5 6 7 9 11 15 17 30]
emptycell{3,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 17 25 27 28]
emptycell{4,2} = [4 7 9 10 13 14 16 24 27 28 29]
emptycell{5,2} = [1 2 3 4 5 7 8 9 10 13 20]
emptycell{6,2} = [2 3 4 5 6 7 8 9 10 11 12 13 14 17 20 23 30]
emptycell{7,2} = [1 2 3 4 5 6 8 9 10 11 12 13]
emptycell{8,2} = [1 5 7 8 9 10]
emptycell{9,2} = [1 2 3 4 5 6 7 8 9 10 12 17 19 20 23 28]
emptycell{10,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 16 19 21]
emptycell{11,2} = [1 2 3 4 5 6 7 10 11 12 13 16 23]
emptycell{12,2} = [1 2 3 4 5 6 8 10 11 12 13 14 16 18 23]
emptycell{13,2} = [1 2 6 9 10 11 12 13 14 18 22]
emptycell{14,2} = [1 2 3 4 5 6 8 9 10 11 12 13 14 15 17]
emptycell{15,2} = [1 2 3 5 6 7 8 10 11 12 13 14 16 18 23]
emptycell{16,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 25 27]
emptycell{17,2} = [1 2 3 4 5 7 8 9 12 13 18 23 26 27 28]
emptycell{18,2} = [1 2 4 5 6 7 8 9 11 14 16 17 18 24]
emptycell{19,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 19]
emptycell{20,2} = [1 2 3 4 6 7 9 11 12 13 15 21]
emptycell{21,2} = [1 2 4 6 7 8 9 10 12 13 14 16 19 21 22 27 28]
emptycell{22,2} = [1 2 3 5 10 12 14 18 21 26 28 30]
emptycell{23,2} = [1 2 3 4 5 6 11 29]
emptycell{24,2} = [1 2 3 4 5 6 7 8 9 10 11 13 14]
emptycell{25,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 16]
emptycell{26,2} = [1 2 3 4 5 6 8 11 13 14 21 23 27]
emptycell{27,2} = [1 2 3 5 6 8 9 10 11 12 13 14 15 24 28]
emptycell{28,2} = [1 2 3 4 5 6 7 8 9 10 11 13 15 23 27 28]
emptycell{29,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 28 30]
emptycell{30,2} = [1 2 3 9 14 17 18 19 23]
emptycell{31,2} = [1 3 5 9 13 19 23 27 30]
emptycell{32,2} = [1 2 3 5 6 7 8 10 11 12 13 14 20 22 23 27]
emptycell{33,2} = [1 2 3 4 5 6 7 9 10 11 12 13 14]
emptycell{34,2} = [1 2 3 4 5 6 8 10 11 12 13 19 28 30]
emptycell{35,2} = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 17 22 23 24 26 27]
emptycell{36,2} = [1 2 3 5 7 8 9 11 13 14 17 21 24 30]
emptycell{37,2} = [1 2 3 4 5 6 7 8 9 10 12 13 15 16 18 20 21 25 26 28 29 30]
emptycell{38,2} = [1 2 4 6 8 9 10 12 18 22 26 27 28]
emptycell{39,2} = [1 2 3 6 7 9 11 13 17 18 26]
emptycell{40,2} = [1 2 3 4 5 6 8 9 10 11 12 13 14 16 17 20 26 30]



for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;


%--------------------------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%if needed
EEG.icaact = (EEG.icaweights*EEG.icasphere)*EEG.data(EEG.icachansind,:);
eeglab redraw

%--------------------------------------------------------------------
%pv = zeros(30,1)

%for d=1:30
%pvaf=eeg_pvaf(EEG,[d]);
%pv(d,:) = pvaf;
%end

%allOneString = sprintf('%.0f,' , transpose(pv));
%allOneString = allOneString(1:end-1);% strip final comma
%allOneString
%eeglab redraw
%--------------------------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, emptycell{a,2}, 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

%--------------------------------------------------------------------
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end






%Channel deletion---------------------------------------------------
chancell = cell(30,2)
for a=1:30
chancell{a,1} = a;
chancell{a,2} = EEG.chanlocs(a).labels;
end




chancell = cell(40,2)
for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2');
N=eeg_dir(c).name;
chancell{a,1} = N;

end


chancell{1,2} = [18]
chancell{2,2} = [2 23]
chancell{3,2} = [2]
chancell{4,2} = [2 15 21 23]
chancell{5,2} = [1 21 23]
chancell{6,2} = [23]
chancell{7,2} = [2 23]
chancell{8,2} = []
chancell{9,2} = []
chancell{10,2} = []
chancell{11,2} = [2 18]
chancell{12,2} = [11]
chancell{13,2} = [2 21 23]
chancell{14,2} = []
chancell{15,2} = [1 23]
chancell{16,2} = [1 2 28]
chancell{17,2} = []
chancell{18,2} = [2 23]
chancell{19,2} = []
chancell{20,2} = [21 23]
chancell{21,2} = [21 22 23]
chancell{22,2} = []
chancell{23,2} = [2 21 23]
chancell{24,2} = []
chancell{25,2} = []
chancell{26,2} = [1 8 21]
chancell{27,2} = [1 17 20 23 25]
chancell{28,2} = [1 13]
chancell{29,2} = []
chancell{30,2} = [21]
chancell{31,2} = []
chancell{32,2} = []
chancell{33,2} = []
chancell{34,2} = []
chancell{35,2} = []
chancell{36,2} = [15 16]
chancell{37,2} = []
chancell{38,2} = []
chancell{39,2} = []
chancell{40,2} = [1 2 5]


for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/Pre_process_2');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG, chancell{a,2}, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end








%Load Epoch --------------------------------------------

for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '44'  }, [0  4], 'newname', 'pruned with ICA epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [0  3998]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del_epoch_eo');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end




%Load Epoch delete --------------------------------------------

for a=1:40
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del_epoch_ec');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_del_chan_del_epoch_ec');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

stdData = std(EEG.data,0,2);
size(stdData)

value = squeeze(mean(stdData,1))

x = [1:size(stdData,3)];
x = x'
%'

concat = [x,value]

mean_concat = mean(concat(:,2))
std_concat = std(concat(:,2))

z_score = zeros(size(x))

for d=1:size(x,1)
z=(concat(d,2)-mean_concat)/std_concat;
z_score(d,:) = z;
end

concat2 = [concat,z_score]

del1 = find(concat2(:,3)>2.33)
del2 = find(concat2(:,3)<-2.5)
del3 = [del1',del2']


EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, del1 ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
close all

end







%Pwelch-------------------------------------------------------
pw_mat_ec_before = zeros(30, 257,20);

for a=1:19
c=2+2*a
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/Before');
N=eeg_dir(c).name;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/COVID/ICA_chan_epoch_ec_del/Before');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%---
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

disp(channel);
totalp(channel,:) = mpow;

end

pw_mat_ec_before(:,:,a) = totalp;

close all

end
