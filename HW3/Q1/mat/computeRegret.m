function [regret,modelLoss] = computeRegret(modelPredictions, alternativePredictions, labels)

%% Compute the instantaneous regret given model's predictions up to time t; the predictions made by an alternative set of models; the true labels.
% Inputs: modelPredictions - this is a 1 by t vector giving the predictions made by the model over the first t iterations
%         alternativePredictions - this is an n by t matrix containing the predictions made by an alternative set of n models over the first t iterations
%         labels - this is an 1 by t vector containing the true labels
% Outputs: regret - the instantaneous regret at iteration t
%          modelLoss - the instantaneous loss at iteration t


%% IMPLEMENT REGRET CALCULATION HERE

%% The instantaneous loss at iteration t
modelLoss = squaredErrorLoss(modelPredictions, labels);

%% find the best model
minimum = squaredErrorLoss(alternativePredictions(1,:),labels);
for i = 2:size(alternativePredictions, 1)
    minimum = min(minimum, squaredErrorLoss(alternativePredictions(i,:),labels)); 
end

%% compute regret now
regret = modelLoss - minimum;


end

