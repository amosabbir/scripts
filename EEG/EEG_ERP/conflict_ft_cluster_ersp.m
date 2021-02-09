addpath(genpath('~/data/toolboxes/fieldtrip-20081218'));


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','accept_crit_words_pruned.set','filepath','/rri_disks/pales/local/home/jed/data/conflict/Monolinguals/101/accept/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

eegdata = eeglab2fieldtrip(EEG,'preprocessing')

load /nysa/meltzer_lab/jed/data/conflict/Monolinguals/accept_critword_erspall
subE1 = E;
clear E
load /nysa/meltzer_lab/jed/data/conflict/Bilinguals/accept_critword_erspall
subE2 = E;
clear E
E = cat(1,subE1,subE2);


%to pad missing data with Nan
for subj = 1:size(E,1)
for i = 1:size(E,2)
if isempty(E(subj,i).label)
subj
i
E(subj,i).ersp_ctl =  nan*ones(size(E(1,i).ersp_ctl));
E(subj,i).ersp_sem =  nan*ones(size(E(1,i).ersp_sem));
E(subj,i).ersp_syn =  nan*ones(size(E(1,i).ersp_syn));
end
end
end

%%%% now concatenate to one array
%%%% we have subjects, electrodes, time, and freq
clear actersp ctlersp
%for i = 1:1 %should be 1:34
temp_ersp_ctl = [];
temp_ersp_sem = [];
temp_ersp_syn = [];

%make these subj,elec,freq,times
for subj = 1:size(E,1)
for i = 1:size(E,2)
temp_ersp_ctl(subj,i,:,:) = E(subj,i).ersp_ctl;
temp_ersp_sem(subj,i,:,:) = E(subj,i).ersp_sem;
temp_ersp_syn(subj,i,:,:) = E(subj,i).ersp_syn;
end %for i
end %for subj

%free up memory by clearing E
clear E

%%for averaging together multiple conditions for statistical comparison
%  actpow = squeeze(mean(cat(5,temp_ersp_RSS,temp_ersp_RSO,temp_ersp_RAC),5)); %reversible
%  ctlpow = squeeze(mean(cat(5,temp_ersp_ISS,temp_ersp_ISO,temp_ersp_IAC),5)); %irreversible




%for sem 

actpow = temp_ersp_sem;
ctlpow = temp_ersp_ctl;

clear cfg
cfg.statistic = 'depsamplesT';
cfg.alpha = .025;
%cfg.alphathresh = .05;
cfg.clusteralpha = 0.05;
cfg.neighbourdist  = .6;
cfg.numrandomization  = 500;
cfg.minnbchan = 1;
%cfg.method = 'analytic';
  cfg.method = 'montecarlo';
%  cfg.method = 'stats';
  cfg.correctm = 'cluster';
  cfg.clusterstatistic = 'maxsum';
cfg.freq = freqs;
cfg.time = times;
cfg.frequency = [0 50];
%cfg.latency = [0.5 6];
cfg.latency = 'all';
%cfg.channel = {'EEG'}

design = zeros(2,2*size(actpow,1))
design(1,:) = [1:size(actpow,1) 1:size(actpow,1)]
design(2,:) = [1*ones(1,size(actpow,1)) 2*ones(1,size(actpow,1))]
cfg.design = design;
cfg.uvar = 1;
cfg.ivar = 2;


eegdata.dimord = 'subj_chan_freq_time';
eegdata.freq = freqs;
eegdata.time = times;
eegdata.toi = times;
actdata = eegdata;
actdata.powspctrm = actpow;
ctldata = eegdata;
ctldata.powspctrm = ctlpow;

ftstats = freqstatistics(cfg,actdata,ctldata);

save /nysa/meltzer_lab/jed/data/conflict/cluster_anal/ftclus_monobiling_accept_sem025 ftstats


%%%%%%%%%% for syn
actpow = temp_ersp_syn;
ctlpow = temp_ersp_ctl;

clear cfg
cfg.statistic = 'depsamplesT';
cfg.alpha = .025;
%cfg.alphathresh = .05;
cfg.clusteralpha = 0.05;
cfg.neighbourdist  = .6;
cfg.numrandomization  = 500;
cfg.minnbchan = 1;
%cfg.method = 'analytic';
  cfg.method = 'montecarlo';
%  cfg.method = 'stats';
  cfg.correctm = 'cluster';
  cfg.clusterstatistic = 'maxsum';
cfg.freq = freqs;
cfg.time = times;
cfg.frequency = [0 50];
%cfg.latency = [0.5 6];
cfg.latency = 'all';
%cfg.channel = {'EEG'}

design = zeros(2,2*size(actpow,1))
design(1,:) = [1:size(actpow,1) 1:size(actpow,1)]
design(2,:) = [1*ones(1,size(actpow,1)) 2*ones(1,size(actpow,1))]
cfg.design = design;
cfg.uvar = 1;
cfg.ivar = 2;


eegdata.dimord = 'subj_chan_freq_time';
eegdata.freq = freqs;
eegdata.time = times;
eegdata.toi = times;
actdata = eegdata;
actdata.powspctrm = actpow;
ctldata = eegdata;
ctldata.powspctrm = ctlpow;

ftstats = freqstatistics(cfg,actdata,ctldata);

save /nysa/meltzer_lab/jed/data/conflict/cluster_anal/ftclus_monobiling_accept_syn025 ftstats


%%%%%%%%%%%%%%add up by frequency, sum over both channels and timepoints
possigcnt = zeros(1,length(ftstats.freq));
negsigcnt = zeros(1,length(ftstats.freq));
for freq = 1:length(ftstats.freq)
  possigcnt(freq) = length(find( (ftstats.prob(:,freq,:)<.05) & (ftstats.stat(:,freq,:) > 0)));
  negsigcnt(freq) = length(find( (ftstats.prob(:,freq,:)<.05) & (ftstats.stat(:,freq,:) < 0)));
%possigcnt(freq) = length(find( (ftstats.prob(:,freq,111:160)<.05) & (ftstats.stat(:,freq,111:160) > 0)));
%negsigcnt(freq) = length(find( (ftstats.prob(:,freq,111:160)<.05) & (ftstats.stat(:,freq,111:160) < 0)));
%cpossigcnt(freq) = length(find( (ftstats.prob(:,freq)<.05) & (ftstats.stat(:,freq) > 0) & (ftstats.posclusterslabelmat(:,freq)==1)));
%cnegsigcnt(freq) = length(find( (ftstats.prob(:,freq)<.05) & (ftstats.stat(:,freq) < 0) & (ftstats.negclusterslabelmat(:,freq)==1)));
end
figure();
plot(ftstats.freq,negsigcnt,'b');
hold on
plot(ftstats.freq,possigcnt,'r');
hold off


%%%%%%%%%%%%%%add up by time, sum over both channels and frequencies
possigcnt = zeros(1,length(ftstats.time));
negsigcnt = zeros(1,length(ftstats.time));
for time = 1:length(ftstats.time)
%  possigcnt(time) = length(find( (ftstats.prob(:,:,time)<.05) & (ftstats.stat(:,:,time) > 0)));
%  negsigcnt(time) = length(find( (ftstats.prob(:,:,time)<.05) & (ftstats.stat(:,:,time) < 0)));
possigcnt(time) = length(find( (ftstats.prob(:,:,time)<.05) & (ftstats.stat(:,:,time) > 0)));
negsigcnt(time) = length(find( (ftstats.prob(:,:,time)<.05) & (ftstats.stat(:,:,time) < 0)));
%cpossigcnt(freq) = length(find( (ftstats.prob(:,freq)<.05) & (ftstats.stat(:,freq) > 0) & (ftstats.posclusterslabelmat(:,freq)==1)));
%cnegsigcnt(freq) = length(find( (ftstats.prob(:,freq)<.05) & (ftstats.stat(:,freq) < 0) & (ftstats.negclusterslabelmat(:,freq)==1)));
end
figure();
plot(ftstats.time,negsigcnt,'b');
hold on
plot(ftstats.time,possigcnt,'r');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55


%%%%%%%%%%%%%to plot positions
%this needs to be troubleshot - need to average across subjects to plot the raw effect!
%that's done, but it can't seem to plot the electrode layout.
vsdata = actdata;
temp1 = actpow - ctlpow;
temp2 = squeeze(mean(temp1,1));
vsdata.dimord = 'chan_freq_time';
vsdata.powspctrm = temp2 %.* (ftstats.prob<.05);
neg = (ftstats.negclusterslabelmat==1)*(-1);
figure;
lfoi = 8;  % frequency of interest
ufoi = 30;  % frequency of interest

for ltoi = 100:200:7000
utoi = ltoi + 200;
%toi = 2500;
z = abs(ftstats.freq-lfoi);
index_lfoi = find(min(z)==z);
z = abs(ftstats.freq-ufoi);
index_ufoi = find(min(z)==z);
z = abs(ftstats.time-ltoi);
index_ltoi = find(min(z)==z);
z = abs(ftstats.time-utoi);
index_utoi = find(min(z)==z);
     cfg = [];
 %    cfg.colormap = colormap('cool');
%     cfg.interplimits = 'electrodes';
       cfg.xlim=[ltoi utoi];
       cfg.ylim = [lfoi ufoi];
       cfg.zlim = [0.3*min(min(min(vsdata.powspctrm))) -0.3*min(min(min(vsdata.powspctrm)))];
%     cfg.highlight = find( mean(mean(ftstats.prob(:,index_lfoi:index_ufoi,index_ltoi:index_utoi),2),3)<.05);
     cfg.highlight = find( any(any(ftstats.prob(:,index_lfoi:index_ufoi,index_ltoi:index_utoi)<.05,2),3));
     cfg.comment = 'xlim';
     cfg.commentpos = 'title';
     cfg.layout = vsdata.elec;
       cfg.zparam = 'powspctrm';
%       cfg.maplimits = 'maxmin';
%         cfg.yparam = 'freq';
%         cfg.xparam = 'time';
	cfg.hlmarkersize = 8;
  	cfg.hllinewidth  = 5;
     topoplotTFR(cfg, vsdata);
     colorbar;
pause
end
