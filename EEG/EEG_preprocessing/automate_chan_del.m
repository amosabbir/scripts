size(EEG.data)
cont = reshape(EEG.data, 76, []);
stdData_channel = std(cont,0,2);
size(stdData_channel)

m = [1:size(stdData,1)]';
%'

concat_chan = [m,stdData_channel]

mean_concat_chan = mean(concat_chan(:,2))
std_concat_chan = std(concat_chan(:,2))

z_score = zeros(size(m))

for e=1:size(m,1)
z2=(concat_chan(e,2)-mean_concat_chan)/std_concat_chan;
z_score2(e,:) = z2;
end

concat_chan2 = [concat_chan,z_score2]


del1 = find(concat_chan2(:,3)>2.33)
del2 = find(concat_chan2(:,3)<-2.5)
del3 = [del1',del2']
