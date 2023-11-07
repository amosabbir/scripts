% /rri_disks/leto/meltzer_lab/shared/toolboxes/eeglab2021.1
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC')


ICAnumber = cell(40,1);
ICAnumber{1,1} = [1,3,4,5,6,7,10,11,12,13];
ICAnumber{2,1} = [1,9,13,18,19,22,23,25];
ICAnumber{3,1} = [1,3,4,6,7,9,10,13,21];
ICAnumber{4,1} = [1,7,9,10,13,14,19,21];
ICAnumber{5,1} = [2,4,6,7,10,12,15,17,18];
ICAnumber{6,1} = [1,2,5,6,8,9,12,13,15];
ICAnumber{7,1} = [1,4,5,6,8,9,10,11,13];
ICAnumber{8,1} = [1,3,5,6,7,8,9,11,13,15];
ICAnumber{9,1} = [1,2,3,5,6,8,10,11,13,16];
ICAnumber{10,1} = [1,3,5,7,9,10,11,12,13,15];
ICAnumber{11,1} = [1,2,3,4,5,8,11,12,18];
ICAnumber{12,1} = [1,3,5,6,10,12,14,17,18,21];
ICAnumber{13,1} = [1,2,4,8,13,15,16,17,18];
ICAnumber{14,1} = [1,2,6,7,9,10,11,13,16,17];
ICAnumber{15,1} = [1,2,3,4,6,12,16,21,23];
ICAnumber{16,1} = [1,2,3,4,5,8,9,10,12,13];
ICAnumber{17,1} = [1,2,6,9,11,12,13,14];
ICAnumber{18,1} = [1,4,6,11,14,17,20,22];
ICAnumber{19,1} = [1,2,3,4,5,12,13,14,27];
ICAnumber{20,1} = [1,2,3,4,5,6,7,8,14];
ICAnumber{21,1} = [2,3,5,6,8,9,11];
ICAnumber{22,1} = [2,5,6,9,19,20,22,24,26];
ICAnumber{23,1} = [7,10,11,13,14,16,18,20];
ICAnumber{24,1} = [1,6,7,9,10,14,16];
ICAnumber{25,1} = [2,3,7,9,10,13,17,18,20];
ICAnumber{26,1} = [1,3,4,7,9,10,12];
ICAnumber{27,1} = [1,2,3,5,6,7,8,16];
ICAnumber{28,1} = [2,3,4,6,9,12,13,19,20];
ICAnumber{29,1} = [1,2,5,6,8,18,20,21,22];
ICAnumber{30,1} = [2,3,9,13,14,15,19,21,22];
ICAnumber{31,1} = [1,2,4,7,8,11,12,17,18,24];
ICAnumber{32,1} = [3,4,5,6,8,9,10,11,12];
ICAnumber{33,1} = [1,2,3,5,6,7,10,11];
ICAnumber{34,1} = [1,8,9,11,18,24];
ICAnumber{35,1} = [1,3,4,5,6,7,9,10,11];
ICAnumber{36,1} = [3,4,5,7,10,14,15,16];
ICAnumber{37,1} = [1,2,3,5,6,7,8,10,12];
ICAnumber{38,1} = [1,4,7,9,10,12,17,21,23,25];
ICAnumber{39,1} = [2,3,5,7,8,9,13];
ICAnumber{40,1} = [1,2,6,12,13,14,15,17,18,19];


ep_number = cell(40,1);
ep_number{1,1} = [19,23,28];
ep_number{2,1} = [29];
ep_number{3,1} = [1,20,22];
ep_number{4,1} = [1,22,23];
ep_number{5,1} = [1,7,11,20,30];
ep_number{6,1} = [5];
ep_number{7,1} = [];
ep_number{8,1} = [];
ep_number{9,1} = [1,2,9,10,11,12,14,15,17,19,26];
ep_number{10,1} = [1,24];
ep_number{11,1} = [];
ep_number{12,1} = [];
ep_number{13,1} = [];
ep_number{14,1} = [13,17];
ep_number{15,1} = [22,24,25,26,27];
ep_number{16,1} = [3,4,5,8,10,13,14,15,17,18,19,20,21,22,23,24,25,26,28,29,30];
ep_number{17,1} = [];
ep_number{18,1} = [];
ep_number{19,1} = [2,29];
ep_number{20,1} = [1,22];
ep_number{21,1} = [4,5,7,9,12,13,14,16,17,19,20,21,22,23,24,25,27,28,29,30];
ep_number{22,1} = [];
ep_number{23,1} = [];
ep_number{24,1} = [9,25];
ep_number{25,1} = [];
ep_number{26,1} = [];
ep_number{27,1} = [];
ep_number{28,1} = [];
ep_number{29,1} = [9,18];
ep_number{30,1} = [24];
ep_number{31,1} = [];
ep_number{32,1} = [];
ep_number{33,1} = [];
ep_number{34,1} = [9,24];
ep_number{35,1} = [5,9,10,15,16,20,23];
ep_number{36,1} = [];
ep_number{37,1} = [1,2,3,4,5,6,7,9,11,13,17,18,20,21,22,23,24,25,26,27,28,29];
ep_number{38,1} = [];
ep_number{39,1} = [1];
ep_number{40,1} = [5,8,13,15,16,18,20,22,25,27,30];

ch_number = cell(40,1);
ch_number{1,1} = [1,2,5,9,10,27,30];
ch_number{2,1} = [30];
ch_number{3,1} = [1,3,5,6,24,29,30];
ch_number{4,1} = [5,6,11,20,25,28];
ch_number{5,1} = [];
ch_number{6,1} = [1,2,4,21,25,26,27];
ch_number{7,1} = [6,8,21,22,28];
ch_number{8,1} = [4,5,19,30];
ch_number{9,1} = [];
ch_number{10,1} = [5,10,13,20,24,25,30];
ch_number{11,1} = [7,10,13,14,21,28];
ch_number{12,1} = [10,11,12,13,21];
ch_number{13,1} = [1,9,11,19,27,28];
ch_number{14,1} = [1,2,12,19,30];
ch_number{15,1} = [1,2,30];
ch_number{16,1} = [];
ch_number{17,1} = [1,2,6,14,24,28,30];
ch_number{18,1} = [5,6,28];
ch_number{19,1} = [];
ch_number{20,1} = [1,2,3,10,11,12,22];
ch_number{21,1} = [];
ch_number{22,1} = [5,24];
ch_number{23,1} = [];
ch_number{24,1} = [2,6,20,25];
ch_number{25,1} = [];
ch_number{26,1} = [1,2,8,12,13,16];
ch_number{27,1} = [2,13,16,18];
ch_number{28,1} = [1,2,6,21];
ch_number{29,1} = [5,6,25];
ch_number{30,1} = [21,24,29];
ch_number{31,1} = [1,2,14,24];
ch_number{32,1} = [11,13,19,20,21,25];
ch_number{33,1} = [13,16,20];
ch_number{34,1} = [12,14,16,20,28];
ch_number{35,1} = [1,2,6,11,12,13,18];
ch_number{36,1} = [];
ch_number{37,1} = [];
ch_number{38,1} = [];
ch_number{39,1} = [];
ch_number{40,1} = []; 


comp_number = cell(40,4)

for a = 1:40
c = (a*2)+2;
comp_number(a,1) = {c}
comp_number(a,2) = {eeg_dir(c).name}
comp_number(a,3) = ICAnumber(a,1)
comp_number(a,4) = ep_number(a,1)
end




%load, delete component, delete channel, save

for a = 1:40
c = (a*2)+2;
eeg_dir=dir('/rri_disks/artemis/meltzer_lab/COVID/EEG_files')
eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC')

%file name saving ---------------------------------------------------------------
N=eeg_dir(c).name;


%--------------------------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%if needed
EEG.icaact = (EEG.icaweights*EEG.icasphere)*EEG.data(EEG.icachansind,:);
eeglab redraw

%component deletion
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, comp_number{a,3}, 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 

%epoch rejection
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, comp_number{a,4} ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'gui','off'); 


EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',eeg_dir(c).name,'filepath','/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EC_del');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

%--------------------------------------------------------------------
%pv = zeros(64,1)
%for d=1:64
%pvaf=eeg_pvaf(EEG,[d]);
%pv(d,:) = pvaf;
%end
%allOneString = sprintf('%.0f,' , transpose(pv));
%allOneString = allOneString(1:end-1);% strip final comma
%allOneString
%eeglab redraw
%--------------------------------------------------------------------


close all

end





%
%
%for eyes open
%
%


eeg_dir=dir('/rri_disks/eugenia/meltzer_lab/amosabbir/COVID/PP_ICA_EO')

ICAnumber = cell(40,1);
ICAnumber{1,1} = [1,2,3,4,8,9,11,12,14,15];
ICAnumber{2,1} = [1,3,8,11,14,16,17,22];
ICAnumber{3,1} = [1,2,4,7,11,13,14,16,17,18];
ICAnumber{4,1} = [1,2,3,5,7,8,13,15,20];
ICAnumber{5,1} = [1,2,4,5,6,9,11,14,15];
ICAnumber{6,1} = [1,2,3,5,6,7,10,11];
ICAnumber{7,1} = [3,4,6,7,8,10,11,12,15];
ICAnumber{8,1} = [1,2,3,6,8,11,12,13,15,18];
ICAnumber{9,1} = [1,2,5,8,13,14,17,18,20,21];
ICAnumber{10,1} = [2,5,6,7,8,10,12,13,21,22];
ICAnumber{11,1} = [1,2,3,5,6,8,9,11,12];
ICAnumber{12,1} = [1,2,3,4,6,9,10,11,19,21];
ICAnumber{13,1} = [1,2,3,4,5,6,7,8,10];
ICAnumber{14,1} = [1,2,3,6,7,8,14,15,16,26];
ICAnumber{15,1} = [1,2,3,4,7,8,10,14,21];
ICAnumber{16,1} = [1,2,3,7,9,10,14,15,16,24];
ICAnumber{17,1} = [1,3,4,5,8,11,14,22];
ICAnumber{18,1} = [2,4,9,14,18,20,22,24];
ICAnumber{19,1} = [1,2,4,5,6,7,11,12,13];
ICAnumber{20,1} = [1,2,3,4,6,7,8,10,13];
ICAnumber{21,1} = [3,6,7,8,9,11,12];
ICAnumber{22,1} = [1,2,7,10,13,17,18,25];
ICAnumber{23,1} = [1,2,3,7,13,14,15,16];
ICAnumber{24,1} = [1,2,3,4,6,8,12];
ICAnumber{25,1} = [2,4,7,8,11,12,13,15,16];
ICAnumber{26,1} = [2,4,6,7,8,10,12,14,15];
ICAnumber{27,1} = [1,3,4,8,9,11,12,14];
ICAnumber{28,1} = [1,2,3,4,8,10,11,13,15];
ICAnumber{29,1} = [2,3,5,6,12,13,15,19,28];
ICAnumber{30,1} = [1,2,4,8,9,10,13,14,17];
ICAnumber{31,1} = [1,2,5,6,7,9,10,21,22,26];
ICAnumber{32,1} = [1,4,5,6,7,9,10,11,12];
ICAnumber{33,1} = [4,5,6,7,8,9,11,12];
ICAnumber{34,1} = [2,3,10,12,14,15,16,18];
ICAnumber{35,1} = [1,2,3,4,5,6,9,10,11,20];
ICAnumber{36,1} = [2,4,5,6,8,10,11,17];
ICAnumber{37,1} = [1,3,4,7,13,14,16,20,26];
ICAnumber{38,1} = [1,2,3,4,11,12,13,14,16,18];
ICAnumber{39,1} = [1,2,4,5,6,8,11,12];
ICAnumber{40,1} = [1,2,3,4,5,9,11,13,17,21];


ep_number = cell(40,1);
ep_number{1,1} = [22,30];
ep_number{2,1} = [28];
ep_number{3,1} = [6,19,20,21,30];
ep_number{4,1} = [];
ep_number{5,1} = [9,10,12,15,18,20,21,22];
ep_number{6,1} = [5];
ep_number{7,1} = [];
ep_number{8,1} = [21];
ep_number{9,1} = [1,2,3,5,8,11,12,13,14,16,20,21,25];
ep_number{10,1} = [2,4,23];
ep_number{11,1} = [];
ep_number{12,1} = [10,12,30];
ep_number{13,1} = [3];
ep_number{14,1} = [4,5];
ep_number{15,1} = [20,21,22,24,25,26];
ep_number{16,1} = [2,3,4,5,6,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29];
ep_number{17,1} = [];
ep_number{18,1} = [];
ep_number{19,1} = [27,29];
ep_number{20,1} = [17];
ep_number{21,1} = [2,3,5,7,8,9,10,11,12,13,14,15,16,18,20,21,22,23,24,25,26,27,28];
ep_number{22,1} = [15];
ep_number{23,1} = [21];
ep_number{24,1} = [];
ep_number{25,1} = [];
ep_number{26,1} = [];
ep_number{27,1} = [];
ep_number{28,1} = [];
ep_number{29,1} = [];
ep_number{30,1} = [];
ep_number{31,1} = [];
ep_number{32,1} = [];
ep_number{33,1} = [];
ep_number{34,1} = [];
ep_number{35,1} = [9,10];
ep_number{36,1} = [21];
ep_number{37,1} = [1,7,11,12,13,14,15,16,17,18,19,20,21,22,23];
ep_number{38,1} = [];
ep_number{39,1} = [7];
ep_number{40,1} = [3,6,12,14,15,18,19,20,22,27];


ch_number = cell(40,1);
ch_number{1,1} = [1,2];
ch_number{2,1} = [];
ch_number{3,1} = [24];
ch_number{4,1} = [];
ch_number{5,1} = [];
ch_number{6,1} = [2,4,21,25,27,30];
ch_number{7,1} = [15];
ch_number{8,1} = [5];
ch_number{9,1} = [];
ch_number{10,1} = [5,13,20,24,25];
ch_number{11,1} = [13,21,23,24];
ch_number{12,1} = [10,11,21,30];
ch_number{13,1} = [9,11,27];
ch_number{14,1} = [2,19,30];
ch_number{15,1} = [2,30];
ch_number{16,1} = [];
ch_number{17,1} = [14,24];
ch_number{18,1} = [];
ch_number{19,1} = [24,28];
ch_number{20,1} = [3,10,18,20,28];
ch_number{21,1} = [];
ch_number{22,1} = [5,13,16,24,26];
ch_number{23,1} = [];
ch_number{24,1} = [6,19,20,25];
ch_number{25,1} = [16,25];
ch_number{26,1} = [];
ch_number{27,1} = [18,];
ch_number{28,1} = [];
ch_number{29,1} = [];
ch_number{30,1} = [21,24,28,29];
ch_number{31,1} = [1,2,12,24];
ch_number{32,1} = [11,12,13,25];
ch_number{33,1} = [14,24];
ch_number{34,1} = [5,6,11,12,14,28];
ch_number{35,1} = [2,11,12,13,14,19,20,21];
ch_number{36,1} = [];
ch_number{37,1} = [];
ch_number{38,1} = [5];
ch_number{39,1} = [5,10,12,14,19];
ch_number{40,1} = []; 


comp_number = cell(40,4)

for a = 1:40
c = (a*2)+2;
comp_number(a,1) = {c}
comp_number(a,2) = {eeg_dir(c).name}
comp_number(a,3) = ICAnumber(a,1)
comp_number(a,4) = ep_number(a,1)
end