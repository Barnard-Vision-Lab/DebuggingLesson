N = 10; %number of subjects
conditions = [1 2 3 4];
nCond = length(conditions);
%loop through subjects 
propCorrect = NaN(N, nCond);
dPrime = NaN(N, nCond);
beta = NaN(N, nCond);
for ii = 1:N
    fileName = sprintf('S%i.csv', ii);
    T = readtable(fullfile('fakeData',fileName));
    
    r = analyzeSubject(T, conditions);

    propCorrect(ii, :) = r.propCorrect;
    dPrime(ii, :) = r.dPrime;
    beta(ii, :) = r.beta;
end

%average over subjects
subjMean = mean(propCorrect, 1, 'omitnan');
subjSEM  = standardError(propCorrect, 1);

% plot means + SEM error bars
figure; hold on;
faceColr = hsv2rgb([0.33 0.6 0.8]);
edgeColr = hsv2rgb([0.33 0.6 0.5]);
plot(conditions, subjMean, 'o', 'MarkerSize', 12, 'MarkerFaceColor', faceColr, 'MarkerEdgeColor', edgeColr);
for ci=1:nCond
   plot(conditions([ci ci]), subjMean(ci)+[-1 1]*subjSEM(ci), '-', 'Color', edgeColr); 
end
set(gca, 'xtick', conditions, 'xlim',[0.5 nCond+0.5], 'ylim', [0.5 1]);
xlabel('condition'); 
ylabel('p(correct'); 
title('Mean accuracy by condition');
