function [weights,errors] = winnow(data, labels)

%% Simulate the Winnow algorithm
% Inputs: data - an n by m matrix where n is the number of instances and m is the number of features
%         labels - a 1 by n vector containing the labels for the instances.
% Output: weights - a 1 by m vector of weights for each feature. large values mean more relevant
%         errors - a scalar indicating the total number of errors made by the classifier

weights = ones(1,size(data,2));
theta = size(data,2)/2; % this is the decision threshold.
errors = 0;
for i=1:size(data,1)
    %%predict
    if sum(weights .* data(i,:)) > theta;
        pred = 1;
    else
        pred = 0;
    end
    
    if pred ~= labels(i)
        errors = errors + 1;
    end
    
    vec = data(i,:);
    for j=1:length(weights)
        if vec(j) ~= labels(i)
            weights(j) = weights(j) / 2;
        end
        if vec(j) == labels(i)
            weights(j) = weights(j) * 2;
        end
    end
end