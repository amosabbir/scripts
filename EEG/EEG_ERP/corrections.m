
addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

for c=1:4

a =[34 38 52 70]
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data')

%file name saving ---------------------------------------------------------------
N=eeg_dir(a(c)).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(a(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('EXG1', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG1'});
	%delete_channel1 = 'EXG1'
	%del_cat = {delete_channel1}
end

if ismember('EXG2', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG2'});
	%delete_channel2 = 'EXG2'
	%del_cat = strcat(del_cat, {' '}, delete_channel2)
end

if ismember('EXG3', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG3'});
	%delete_channel3 = 'EXG3'
	%del_cat = strcat(del_cat, {' '}, delete_channel3)
end

if ismember('EXG4', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG4'});
	%delete_channel4 = 'EXG4'
	%del_cat = strcat(del_cat, {' '}, delete_channel4)
end

if ismember('EXG5', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG5'});
	%delete_channel5 = 'EXG5'
	%del_cat = strcat(del_cat, {' '}, delete_channel5)
end

if ismember('EXG6', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG6'});
	%delete_channel6 = 'EXG6'
	%del_cat = strcat(del_cat, {' '}, delete_channel6)
end

if ismember('EXG7', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG7'});
	%delete_channel7 = 'EXG7'
	%del_cat = strcat(del_cat, {' '}, delete_channel7)
end

if ismember('EXG8', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG8'});
	%delete_channel8 = 'EXG8'
	%del_cat = strcat(del_cat, {' '}, delete_channel8)
end
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw
%END deleting code------------


%interpolate channel ---------------------------------------------------------
if true
  [ID,epoch,channel] = xlsread('Chan_epoch_SE1.xls')
end
epoch(1,:)=[]
d=(a(c)-2)/2
epoch(d,1)

A1={EEG.chanlocs(:).labels}' %'
B1=char(split(epoch(d,3)))
Chan_del=(find(ismember(A1,B1)))' %'


%-----------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG,Chan_del, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');


%Epoch deletion -----------------------------------------------------------------
A=epoch(:,2)
rej_epoch=str2double(sprintf('%s',A{d}))

EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, [5 6] ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%-----------------------------------------------------------------


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(a(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

for c=1:2

b = [10 68]
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data')

%file name saving ---------------------------------------------------------------
N=eeg_dir(b(c)).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(b(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%deleting code------------

List_of_channels={EEG.chanlocs(:).labels}

if ismember('EXG1', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG1'});
	%delete_channel1 = 'EXG1'
	%del_cat = {delete_channel1}
end

if ismember('EXG2', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG2'});
	%delete_channel2 = 'EXG2'
	%del_cat = strcat(del_cat, {' '}, delete_channel2)
end

if ismember('EXG3', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG3'});
	%delete_channel3 = 'EXG3'
	%del_cat = strcat(del_cat, {' '}, delete_channel3)
end

if ismember('EXG4', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG4'});
	%delete_channel4 = 'EXG4'
	%del_cat = strcat(del_cat, {' '}, delete_channel4)
end

if ismember('EXG5', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG5'});
	%delete_channel5 = 'EXG5'
	%del_cat = strcat(del_cat, {' '}, delete_channel5)
end

if ismember('EXG6', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG6'});
	%delete_channel6 = 'EXG6'
	%del_cat = strcat(del_cat, {' '}, delete_channel6)
end

if ismember('EXG7', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG7'});
	%delete_channel7 = 'EXG7'
	%del_cat = strcat(del_cat, {' '}, delete_channel7)
end

if ismember('EXG8', List_of_channels)==1;
	EEG = eeg_checkset( EEG );
	EEG = pop_select( EEG,'nochannel',{'EXG8'});
	%delete_channel8 = 'EXG8'
	%del_cat = strcat(del_cat, {' '}, delete_channel8)
end
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store dataset
eeglab redraw
%END deleting code------------


%interpolate channel ---------------------------------------------------------
if true
  [ID,epoch,channel] = xlsread('Chan_epoch_SE2.xls')
end
epoch(1,:)=[]
d=(b(c)-2)/2
epoch(d,1)

A1={EEG.chanlocs(:).labels}' %'
B1=char(split(epoch(d,3)))
Chan_del=(find(ismember(A1,B1)))' %'


%-----------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG,Chan_del, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');


%Epoch deletion -----------------------------------------------------------------
A=epoch(:,2)
rej_epoch=str2double(sprintf('%s',A{d}))

EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, [rej_epoch] ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');

%-----------------------------------------------------------------


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(b(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all

end


%ICA1---------------------------------------------------


addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

for c=1:4
a =[34 38 52 70]
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch')

%file name saving ---------------------------------------------------------------
N=eeg_dir(a(c)).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(a(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%-----------------------------------------------------------------

%Re-refernce to average

EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
eeglab redraw

%---------

EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',64,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(a(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE1_data_epch_ICA');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all

end



%ICA2---------------------------------------------------


addpath ('/rri_disks/artemis/meltzer_lab')
addpath('/rri_disks/artemis/meltzer_lab/CANBIND')
addpath ('/rri_disks/artemis/meltzer_lab/shared/toolboxes/eeglab13_6_5b/')

for c=1:2

b = [10 68]
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch')

%file name saving ---------------------------------------------------------------
N=eeg_dir(b(c)).name;

%Load dataset--------------------------------------------------------------------

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(b(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%-----------------------------------------------------------------

%Re-refernce to average

EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
eeglab redraw

%---------

EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'pca',64,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(b(c)).name,'filepath','/rri_disks/artemis/meltzer_lab/CANBIND/Anhedonia/SE2_data_epch_ICA');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
clear all
close all

end
