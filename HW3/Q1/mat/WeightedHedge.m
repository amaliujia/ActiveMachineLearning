function [regrets,modelLosses,weights] = WeightedHedge(data,labels,eta)

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
weights = weights/sum(weights);

for i=1:size(data,2)
    WeightedModelPrediction=zeros(1, i);
    for j=1:i
        WeightedModelPrediction(j) = sum(weights .* data(1:end, j:j)'); 
    end
    [regrets(i), modelLosses(i)] = computeRegret(WeightedModelPrediction, data(1:size(data,1), 1:i), labels(1:i)); 
    %%update weights
    weights = weights .* (eta * exp(-1 * abs(data(:,i)' - labels(i))));
    weights = weights/sum(weights);
end

weights=weights/sum(weights); % re-normalize weights
end

