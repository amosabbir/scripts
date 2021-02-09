addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

resp=[1,3,5,9,12,14,19];
tworesp=40+(resp*2);
resp=resp*2+2;
resp=[resp tworesp];


nonresp=[2,4,6,7,8,10,11,13,15,16,17,18];
twononresp=40+(nonresp*2);
nonresp=nonresp*2+2;
nonresp=[nonresp twononresp];


%-Responder Incentive SE1 -----------------------------

for c=1:7
array=[1:7];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(resp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Resp_Inc_SE1{c}=eegdata;


end


%-Responder Nonincentive SE1-----------------------------

for c=1:7
array=[8:14];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(resp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Resp_NonInc_SE1{c}=eegdata;

end



%-Non responder Incentive SE1 -----------------------------

for c=1:12
array=[1:12];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(nonresp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Nonresp_Inc_SE1{c}=eegdata

end


%-Non responder Non incentive SE1-----------------------------

for c=1:12
array=[13:24];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(nonresp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Nonresp_NonInc_SE1{c}=eegdata;

end


%-Responder Incentive SE2 -----------------------------

for c=1:7
array=[1:7];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(resp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Resp_Inc_SE2{c}=eegdata;

end


%-Responder Nonincentive SE2-----------------------------

for c=1:7
array=[8:14];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(resp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(resp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Resp_NonInc_SE2{c}=eegdata;

end



%-Non responder Incentive SE2 -----------------------------

for c=1:12
array=[1:12];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(nonresp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Nonresp_Inc_SE2{c}=eegdata

end


%-Non responder Non incentive SE2-----------------------------

for c=1:12
array=[13:24];

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');

%file name saving ---------------------------------------------------------------
N=eeg_dir(nonresp(array(c))).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(nonresp(array(c))).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'CB1' 'CB2' 'TP9' 'TP10' 'FT9' 'FT10' 'F9' 'F10' 'LO1' 'LO2' 'IO1' 'IO2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

eegdata = eeglab2fieldtrip(EEG,'preprocessing');

dim = ndims(eegdata.time{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.time{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytime = mean(M,dim+1);  %Get the mean across arrays

eegdata.time = meanArraytime;

dim = ndims(eegdata.trial{1});          %Get the number of dimensions for your arrays
M = cat(dim+1,eegdata.trial{:});        %Convert to a (dim+1)-dimensional matrix
meanArraytrial = mean(M,dim+1);  %Get the mean across arrays

eegdata.avg = meanArraytrial;
eegdata.dimord = 'chan_time';
eegdata.trial = [];

Nonresp_NonInc_SE2{c}=eegdata;

end

save Anhedonia_ERP Resp_Inc_SE1 Resp_NonInc_SE1 Nonresp_Inc_SE1 Nonresp_NonInc_SE1 Resp_Inc_SE2 Resp_NonInc_SE2 Nonresp_Inc_SE2 Nonresp_NonInc_SE2
