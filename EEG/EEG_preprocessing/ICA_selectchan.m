[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
visualmarked=CURRENTSET;
eeglab redraw;


% select channels for runica
accessory=[31 32 33 34]; 
EEG = pop_select( EEG, 'channel',accessory);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, ...
    'setname', 'extra_chan');
extra_chan=EEG.data; % create extra_chan variable to append in the end
EEG = eeg_retrieve(ALLEEG, visualmarked); CURRENTSET = visualmarked;
EEG = pop_select( EEG, 'nochannel',accessory);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'noaccessory');
eeglab redraw;

%save extra channels
save('/rri_disks/artemis/meltzer_lab/COVID/Extra_channels/extra_chan.mat','extra_chan')


% runica
EEG = pop_runica(EEG, 'icatype','runica');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


% append extra_chan

load('/rri_disks/artemis/meltzer_lab/COVID/Extra_channels/extra_chan.mat')
icacleaned=CURRENTSET;
EEG = eeg_retrieve(ALLEEG, icacleaned); CURRENTSET = icacleaned;
EEG.data=[EEG.data; extra_chan]; % append deleted channels to cleaned set
EEG.nbchan=EEG.nbchan+size(extra_chan,1);
EEG.chanlocs=pop_chanedit(EEG.chanlocs,  'load',{ '/rri_disks/artemis/meltzer_lab/COVID/Chanlocs.loc', 'filetype',''});




