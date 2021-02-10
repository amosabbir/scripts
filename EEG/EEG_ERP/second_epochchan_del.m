addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

for c=4:2:78

eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%interpolate channel ---------------------------------------------------------
if true
  [ID,epoch,channel] = xlsread('Chan_epoch_SE2.xls')
end
epoch(1,:)=[]
d=(c-2)/2
epoch(d,1)

A1={EEG.chanlocs(:).labels}' %'
B1=char(split(epoch(d,6)))
Chan_del=(find(ismember(A1,B1)))' %'


%-----------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG,Chan_del, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');


%Epoch deletion -----------------------------------------------------------------
A=epoch(:,5)
rej_epoch=str2double(sprintf('%s',A{d}))

EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, [rej_epoch] ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%-----------------------------------------------------------------


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA_del_epch');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all

end

%hello
