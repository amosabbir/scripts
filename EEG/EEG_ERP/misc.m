


Nonresp_Inc_SE1{1} = rmfield(Nonresp_Inc_SE1{1},'trial')
Nonresp_Inc_SE1{2} = rmfield(Nonresp_Inc_SE1{2},'trial')
Nonresp_Inc_SE1{3} = rmfield(Nonresp_Inc_SE1{3},'trial')
Nonresp_Inc_SE1{4} = rmfield(Nonresp_Inc_SE1{4},'trial')
Nonresp_Inc_SE1{5} = rmfield(Nonresp_Inc_SE1{5},'trial')
Nonresp_Inc_SE1{6} = rmfield(Nonresp_Inc_SE1{6},'trial')
Nonresp_Inc_SE1{7} = rmfield(Nonresp_Inc_SE1{7},'trial')


cfg = [];
cfg.elec = elec;
cfg.channel = Nonresp_Inc_SE1{1}.label;
cfg.method = 'distance';
cfg.neighbourdist  = 30;
cfg.compress = 'yes';
cfg.feedback = 'yes';
neighbours5 = ft_prepare_neighbours(cfg);
