function totalYeild = replicates

%% run a replicate simulation for question 3
% Output: totalYeild - the total ethanol yeild.

numgenes = 50;
numreplicates = 10;

%% IMPLEMENT ALGORITHM
totalYeild = 0;
for i = 1:50
    for j = 1:10
        totalYeild = totalYeild + RNAiSim(i);
    end
end

end