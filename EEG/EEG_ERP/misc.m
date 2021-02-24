


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
cfg.channel = Resp_pow_SE1{1}.label;
cfg.method = 'triangulation';
%cfg.method = 'distance';
%cfg.neighbourdist  = 30;
cfg.compress = 'yes';
cfg.feedback = 'yes';
neighbours5 = ft_prepare_neighbours(cfg);
