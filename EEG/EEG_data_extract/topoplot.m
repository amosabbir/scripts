dat=a(:,2);
figure; topoplot(dat,EEG.chanlocs); cbar('vert',0,[-1 1]*max(abs(dat)));
