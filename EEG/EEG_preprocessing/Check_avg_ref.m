
% channels to include in avg ref
channels_to_include = [1:64];

% store the raw data
raw = EEG.data;

% the avg to be subtracted from other channels
average = mean( raw(channels_to_include,:), 1 );

% average-referenced data
my_reref = raw - repmat( average, [size(raw,1) 1] );

% rereference using EEGLAB
%EEG = pop_reref(EEG, channels_to_include);
EEG = pop_reref( EEG, [], 'exclude', [65:76]);

% store the eeglab-referenced data
eeglab_reref = EEG.data;

% choose a channel to plot, doesn't really matter which
channel = 5;

% choose some time window to plot, doesn't really matter which
samples = 1:500;

% plot to see if the results are different (if they're the same, which is
%good, you'll see only one line )
figure;
hold on;
plot( 1:500, [my_reref(channel,samples); eeglab_reref(channel,samples)] );
legend( {'re-referenced by hand' 're-referenced using EEGLAB'} );



