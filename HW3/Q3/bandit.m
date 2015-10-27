function totalYeild = bandit

%% run a multi-armned bandit simulation for question 3
% Output: totalYeild - the total ethanol yeild.

numgenes = 50;
numreplicates = 10;

%% IMPLEMENT ALGORITHM
acc = zeros(1, 50);
count = zeros(1, 50);
totalYeild = 0;
%% init the first 50
for i = 1:50
    acc(i) = RNAiSim(i);
    count(i) = 1;
end
totalYeild = sum(acc);

for i = 51:500
    [~, index] = max(acc);
    %% update vector
    cc = RNAiSim(index);
    count(index) = count(index) + 1;
    average = (cc + acc(index)) / 2;
    acc(index) = average + 1.96 * sqrt(((cc - average)^2 + (acc(index)- average)^2) / 2) / count(index);
    totalYeild = totalYeild + cc;
end

end