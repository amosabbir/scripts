


Nonresp_Inc_SE1{1} = rmfield(Nonresp_Inc_SE1{1},'trial')
Nonresp_Inc_SE1{2} = rmfield(Nonresp_Inc_SE1{2},'trial')
Nonresp_Inc_SE1{3} = rmfield(Nonresp_Inc_SE1{3},'trial')
Nonresp_Inc_SE1{4} = rmfield(Nonresp_Inc_SE1{4},'trial')
Nonresp_Inc_SE1{5} = rmfield(Nonresp_Inc_SE1{5},'trial')
Nonresp_Inc_SE1{6} = rmfield(Nonresp_Inc_SE1{6},'trial')
Nonresp_Inc_SE1{7} = rmfield(Nonresp_Inc_SE1{7},'trial')



for c = 1:7

Resp_pow_SE1{c} = rmfield(Resp_pow_SE1{c},'trial')
Resp_pow_SE1{c} = rmfield(Resp_pow_SE1{c},'time')
Resp_pow_SE1{c} = rmfield(Resp_pow_SE1{c},'fsample')
Resp_pow_SE1{c}.label = Resp_pow_SE1{c}.label'  %'
Resp_pow_SE1{c}.freq = Resp_pow_SE1{c}.freq'  %'
Resp_pow_SE1{c}.powspctrm = Resp_pow_SE1{c}.powspctrm(1:64,:)
Resp_pow_SE1{c}.cfg = []

Resp_pow_SE2{c} = rmfield(Resp_pow_SE2{c},'trial')
Resp_pow_SE2{c} = rmfield(Resp_pow_SE2{c},'time')
Resp_pow_SE2{c} = rmfield(Resp_pow_SE2{c},'fsample')
Resp_pow_SE2{c}.label = Resp_pow_SE2{c}.label'  %'
Resp_pow_SE2{c}.freq = Resp_pow_SE2{c}.freq'  %'
Resp_pow_SE2{c}.powspctrm = Resp_pow_SE2{c}.powspctrm(1:64,:)
Resp_pow_SE2{c}.cfg = []

end

for c = 1:12

Nonresp_pow_SE1{c} = rmfield(Nonresp_pow_SE1{c},'trial')
Nonresp_pow_SE1{c} = rmfield(Nonresp_pow_SE1{c},'time')
Nonresp_pow_SE1{c} = rmfield(Nonresp_pow_SE1{c},'fsample')
Nonresp_pow_SE1{c}.label = Nonresp_pow_SE1{c}.label'  %'
Nonresp_pow_SE1{c}.freq = Nonresp_pow_SE1{c}.freq'  %'
Nonresp_pow_SE1{c}.powspctrm = Nonresp_pow_SE1{c}.powspctrm(1:64,:)
Nonresp_pow_SE1{c}.cfg = []

Nonresp_pow_SE2{c} = rmfield(Nonresp_pow_SE2{c},'trial')
Nonresp_pow_SE2{c} = rmfield(Nonresp_pow_SE2{c},'time')
Nonresp_pow_SE2{c} = rmfield(Nonresp_pow_SE2{c},'fsample')
Nonresp_pow_SE2{c}.label = Nonresp_pow_SE2{c}.label'  %'
Nonresp_pow_SE2{c}.freq = Nonresp_pow_SE2{c}.freq'  %'
Nonresp_pow_SE2{c}.powspctrm = Nonresp_pow_SE2{c}.powspctrm(1:64,:)
Nonresp_pow_SE2{c}.cfg = []

end


cfg = [];
cfg.keepindividual = 'yes';
Resp_pow_SE1 = ft_freqgrandaverage(cfg, Resp_pow_SE1{:});
Resp_pow_SE2 = ft_freqgrandaverage(cfg, Resp_pow_SE2{:});
Nonresp_pow_SE1 = ft_freqgrandaverage(cfg, Nonresp_pow_SE1{:});
Nonresp_pow_SE2 = ft_freqgrandaverage(cfg, Nonresp_pow_SE2{:});




cfg = [];
cfg.elec = elec;
cfg.channel = Resp_pow_SE1.label;
cfg.method = 'triangulation';
%cfg.method = 'distance';
%cfg.neighbourdist  = 30;
cfg.compress = 'yes';
cfg.feedback = 'yes';
neighbours5 = ft_prepare_neighbours(cfg);


foi_contrast = [0.5 30];

cfg = [];
cfg.channel          = 'all';
cfg.frequency        = foi_contrast;
cfg.parameter        = 'powspctrm_b';
cfg.method           = 'ft_statistics_montecarlo';  % use the Monte Carlo method to calculate probabilities
cfg.statistic        = 'ft_statfun_depsamplesT';    % use the dependent samples T-statistic as a measure to evaluate the effect at each sample
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;                        % threshold for the sample-specific test, is used for thresholding
cfg.clusterstatistic = 'maxsize';
cfg.clusterthreshold = 'nonparametric_common';
cfg.minnbchan        = 2;                           % minimum number of neighbouring channels that is required
cfg.tail             = 0;                           % test the left, right or both tails of the distribution
cfg.clustertail      = cfg.tail;
cfg.alpha            = 0.05;                        % alpha level of the permutation test
cfg.correcttail      = 'alpha';                     % see https://www.fieldtriptoolbox.org/faq/why_should_i_use_the_cfg.correcttail_option_when_using_statistics_montecarlo/
cfg.computeprob      = 'yes';
cfg.numrandomization = 500;                         % number of random permutations
cfg.neighbours       = cfg_neigh.neighbours;




resp_before=squeeze(mean(Resp_pow_SE1.powspctrm,1))
resp_after=squeeze(mean(Resp_pow_SE2.powspctrm,1))
