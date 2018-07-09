
function [] = plot_one_foof_results(freqs, psd, f_range,fooof_results)

%% get model data 
%calc L
bckgr = fooof_results.background_params;
if numel(bckgr)<3 %offset, slope
    b = bckgr(1); chi = bckgr(2); k = 0;  
else %offset, knee, slope
    b = bckgr(1); chi = bckgr(3); k = bckgr(2);
end

L = b - log10(k+(freqs.^chi));

%calc sumG
gaussians = fooof_results.gaussian_params;% this for plotting. This is used for the fit
% peaks = fooof_results.peak_params; %these are the "true" amplitudes,
% after subtracting the background (and other gaussians?)
nG = size(gaussians,1); nFreqs = numel(freqs); 
G = nan(nG,nFreqs);
for iG = 1:nG
    cf = gaussians(iG,1); a = gaussians(iG,2); w = gaussians(iG,3);
    ee = (-(freqs-cf).^2)./(2*w^2);
    G(iG,:) = a*exp(ee);
end
sumG = sum(G,1); 

%% plot
P = L + sumG; 

figure('color',[1 1 1]); hold on 
plot(freqs,log10(psd),'k'); 
plot(freqs,P,'color',[0.8 0 0.2 .5],'linewidth',2);
plot(freqs,L,'--','color',[0.2 0 0.8 .6],'linewidth',2);

legend('Original Spectrum','Full Model Fit','Background fit')
xlim(f_range); 
grid on
xlabel('Frequency'); ylabel('log10 Power');

% figure; hold on 
% plot(freqs,sumG);
% xlim(f_range);

end%function


