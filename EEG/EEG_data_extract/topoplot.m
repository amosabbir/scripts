a = csvread('topoplot_one.csv',1,2);
dat=a(:,1);
%9
figure; topoplot(dat,EEG.chanlocs,'maplimits',[0 0.75]); cbar('vert',0,[0 0.75]);

%figure; topoplot(dat,EEG.chanlocs,'maplimits',[-2 2]*max(abs(dat))); cbar('vert',0,[-2 2]*max(dat));
caxis([-2 2]*max(dat))
colormap(bluewhitered)
