function HedgeTest(n)
%HEDGETEST Summary of this function goes here
%   Detailed explanation goes here
[data, labels] = getDataForTarget2(n);
total_regret = zeros(1,size(data,2));
total_loss = zeros(1,size(data,2));
for i = 1:100
  [data, labels] = getDataForTarget2(n);
  [regrets, modelLosses,weights] = hedge(data, labels,0.5);
  total_regret = total_regret + regrets;
  total_loss = total_loss + modelLosses;
end
total_regret = total_regret ./ 100;
total_loss = total_loss ./ 100;

t=1:size(data,2);
figure
plot(t, total_regret, '-ro', t, total_loss, '-.b');
legend('regrets', 'losses');                       
end

