
addpath /rri_disks/artemis/meltzer_lab/shared/toolboxes/fieldtrip-20170130
ft_defaults

addpath /rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1

cfg         = [];
cfg.channel = {'all'};
%
cfg.latency = [2 2.5];

cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 1;
cfg.neighbours     = neighbours5;
cfg.neighbourdist  = 30;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;
cfg.frequency = [0 50];
%cfg.dim = [64 3072];

Nsubj  = 7;
design = zeros(2, Nsubj*2);
design(1,:) = [1:Nsubj 1:Nsubj];
design(2,:) = [ones(1,Nsubj) ones(1,Nsubj)*2];
cfg.design = design;
cfg.uvar   = 1;
cfg.ivar   = 2;


%n_one  = 7;
%n_two = 12;
%cfg.design           = [ones(1,n_two), ones(1,n_one)*2]; % design matrix
%cfg.ivar             = 1;


[stat2] = ft_timelockstatistics(cfg, Resp_NonInc_SE1{:}, Resp_NonInc_SE2{:})
stat2.posclusters(1)
stat2.negclusters(1)




[row,col] = find(stat2.posclusterslabelmat==1)
index = [row,col]

Resp_Inc_SE1{1}.label(60)
