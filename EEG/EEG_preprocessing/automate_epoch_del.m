stdData = std(EEG.data,0,2);
size(stdData)

value = squeeze(mean(stdData,1))

x = [1:size(stdData,3)];
x = x'
%'

concat = [x,value]

mean_concat = mean(concat(:,2))
std_concat = std(concat(:,2))

z_score = zeros(size(x))

for d=1:size(x,1)
z=(concat(d,2)-mean_concat)/std_concat;
z_score(d,:) = z;
end

concat2 = [concat,z_score]

del1 = find(concat2(:,3)>2.33)
del2 = find(concat2(:,3)<-2.5)
del3 = [del1',del2']


EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, del1 ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
