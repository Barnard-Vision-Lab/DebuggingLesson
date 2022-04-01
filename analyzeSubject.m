function r = analyzeSubject(T, conditionNumbers) 

%conditionNumbers = unique(T.condition);
numCond = length(conditionNumbers);

T.correct = T.stimCategory == T.responseKey;

%initialized a vector of NaNs to hold the proportion correct values for
%each of the nCond conditions. 
r.propCorrect = NaN(1, numCond);
r.dPrime = NaN(1, numCond);
r.beta = NaN(1, numCond);
%loop through all the conditions, so ci is the index of the current
%condition 
for ci = 1:numCond
%     %1. find the trials that were of this condition
    conditionTrials = T.condition == conditionNumbers(ci);
%     
%     %2. pull out the correctness values for just these trials
    conditionCorrect = T.correct(conditionTrials);
%     
%     %3. compute the proportion correct for this condition by taking the
%     %mean of the vector of 1s and 0s that define whether each trial was
%     %correct or incorrect (sum / number of trials)
    r.propCorrect(ci) = mean(conditionCorrect);
    
    %% compute dprime
    targPres = T.stimCategory(conditionTrials)==2;
    respPres = T.responseKey(conditionTrials)==2;
    [dprm, ~, ~, b] = computeSDT(targPres, respPres);
    r.dPrime(ci) = dprm;
    r.beta(ci) = b;
        
end