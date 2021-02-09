

for c=1:64

pvaf=eeg_pvaf(EEG,c);

pv(c,:) = pvaf;

end


allOneString = sprintf('%.0f,' , transpose(pv));
allOneString = allOneString(1:end-1);% strip final comma
