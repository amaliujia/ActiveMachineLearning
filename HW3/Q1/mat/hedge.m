function [regrets,modelLosses,weights] = hedge(data,labels,eta)

%% Simulate the Hedge Algorithm
% Inputs: data - an n by t matrix where n is the number of experts and t is the number of iterations of the algorithm
%         labels - a 1 by t vector containing the true labels for each of the t iteractions
%         eta - the learning rate, which is a value in (0,1)
% Outputs: regrets - a 1 by t vector containing the INSTANTANEOUS regrets for iterations 1 to t
%          modelLosses - a 1 by t vector containing the INSTANTANEOUS loss at iteration t
%          weights - a 1 by n vector containing the FINAL weights over the experts

weights = ones(1,size(data,1));
modelPredictions = zeros(1,size(data,2));
modelLosses = zeros(1,size(data,2));
regrets = zeros(1,size(data,2));

for i=1:size(data,2)
    weights = weights/sum(weights);
    r = mnrnd(1,weights);
    [~, cur_max] = max(r);
    modelPredictions(1, i) = data(cur_max, i);
    [regrets(i), modelLosses(i)] = computeRegret(modelPredictions(1:i), data(1:size(data,1), 1:i), labels(1:i)); 
    
    %%update weights
    weights = weights .* (eta * exp(-1 * abs(data(:,i)' - labels(i))));

end

weights=weights/sum(weights); % re-normalize weights
end