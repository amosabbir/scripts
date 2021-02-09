
addpath /rri_disks/artemis/meltzer_lab/shared/toolboxes/fieldtrip-20170130
ft_defaults

addpath /rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1

cfg         = [];
%cfg.channel = Resp_Inc_SE1{1}.label';
%'
cfg.latency = 'all';

cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 1;
cfg.neighbours     = neighbours5;
cfg.neighbourdist  = .6;
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
