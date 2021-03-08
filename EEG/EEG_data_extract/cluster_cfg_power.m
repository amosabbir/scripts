
addpath /rri_disks/artemis/meltzer_lab/shared/toolboxes/fieldtrip-20170130
ft_defaults

addpath /rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1

load elec64.mat


cfg = [];
cfg.elec = elec;
cfg.channel = new_Resp_pow.label;
cfg.method = 'triangulation';
%cfg.method = 'distance';
%cfg.neighbourdist  = 100;
cfg.compress = 'yes';
cfg.feedback = 'yes';
neighbours5 = ft_prepare_neighbours(cfg);



cfg         = [];
cfg.channel = 'all';
cfg.frequency        = 'all';
cfg.parameter        = 'powspctrm';
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
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



%Nsubj  = 7;
%design = zeros(2, Nsubj*2);
%design(1,:) = [1:Nsubj 1:Nsubj];
%design(2,:) = [ones(1,Nsubj) ones(1,Nsubj)*2];
%cfg.design = design;
%cfg.uvar   = 1;
%cfg.ivar   = 2;


n_one  = 7;
n_two = 12;
cfg.design           = [ones(1,n_two), ones(1,n_one)*2]; % design matrix
cfg.ivar             = 1;


[stat2] = ft_freqstatistics(cfg, new_Resp_pow, new_nonResp_pow)
%stat2.posclusters(1)
%stat2.negclusters(1)





[row,col] = find(stat2.negclusterslabelmat==1)
index = [row,col]

new_nonResp_pow.label(53)
stat2.freq(8:20)

resp_before=squeeze(mean(new_Resp_pow.powspctrm,1))
resp_after=squeeze(mean(new_nonResp_pow.powspctrm,1))

x=stat2.freq
y=resp_before(1,:)
y2=resp_after(1,:)

plot(x,y)
hold on
plot(x,y2)


for c=1:7
b=squeeze(new_Resp_pow.powspctrm(c,59,:))
filename = 'R%d.png';
filename = sprintf(filename,c)
a=plot(x,b)
saveas(a,filename)
end


for c=1:12
b=squeeze(new_nonResp_pow.powspctrm(c,60,:))
filename = 'NR%d.png';
filename = sprintf(filename,c)
a=plot(x,b)
saveas(a,filename)
end
