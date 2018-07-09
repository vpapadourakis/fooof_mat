%% FOOOF Matlab Wrapper Example - Multiple PSDs

% Load data
load('dat/ch_dat_one.mat');
load('dat/ch_dat_two.mat');

% Combine into a multi-channel data matrix
chs_dat = [ch_dat_one; ch_dat_two]';

% Calculate power spectra with Welch's method
[psds, freqs] = pwelch(chs_dat, 500, [], [], s_rate);

% Transpose, to make FOOOF inputs row vectors
freqs = freqs';

% FOOOF settings
settings = struct();
f_range = [1, 50];

% Run FOOOF across a group of power spectra
fooof_results = fooof_group(freqs, psds, f_range, settings);

% Check out the FOOOF Results
fooof_results

%plot
for i = 1:size(fooof_results,2)
    plot_one_foof_results(freqs, psds(:,i), f_range,fooof_results(i));
end
