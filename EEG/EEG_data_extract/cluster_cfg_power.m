
addpath /rri_disks/artemis/meltzer_lab/shared/toolboxes/fieldtrip-20170130
ft_defaults

addpath /rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1

load elec64.mat


cfg = [];
cfg.elec = elec;
cfg.channel = Resp_pow_SE1.label;
cfg.method = 'triangulation';
%cfg.method = 'distance';
%cfg.neighbourdist  = 30;
cfg.compress = 'yes';
cfg.feedback = 'yes';
neighbours5 = ft_prepare_neighbours(cfg);



cfg         = [];
cfg.channel = 'all';
cfg.frequency        = [0 50];
%cfg.parameter        = 'powspctrm_b';
cfg.method           = 'ft_statistics_montecarlo';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsize';
%cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;                        % alpha level of the permutation test
cfg.correcttail      = 'alpha';                     % see https://www.fieldtriptoolbox.org/faq/why_should_i_use_the_cfg.correcttail_option_when_using_statistics_montecarlo/
cfg.computeprob      = 'yes';
cfg.numrandomization = 500;
cfg.neighbours     = neighbours5;



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


%[stat2] = ft_timelockstatistics(cfg, Resp_NonInc_SE1{:}, Resp_NonInc_SE2{:})
%stat2.posclusters(1)
%stat2.negclusters(1)

ftstats = ft_freqstatistics(cfg, Resp_pow_SE1, Resp_pow_SE2)




[row,col] = find(stat2.posclusterslabelmat==1)
index = [row,col]

Resp_Inc_SE1{1}.label(60)
