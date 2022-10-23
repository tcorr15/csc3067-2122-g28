function [accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate] = evaluateDataset(results)

% function totals all metrics for entire dataset and finds the mean
accuracy=0;
sensitivity=0;
precision=0;
specifity=0;
fMeasure=0;
falseAlarmRate=0;

for i=1:size(results, 1)
    accuracy = accuracy + double(results(i,4));
    sensitivity = sensitivity + double(results(i,5));
    precision = precision + double(results(i,6));
    specifity = specifity + double(results(i,7));
    fMeasure = fMeasure + double(results(i,8));
    falseAlarmRate = falseAlarmRate + double(results(i,9));
end

accuracy=accuracy ./ size(results, 1);
sensitivity=sensitivity ./ size(results, 1);
precision=precision ./ size(results, 1);
specifity=specifity ./ size(results, 1);
fMeasure=fMeasure ./ size(results, 1);
falseAlarmRate=falseAlarmRate ./ size(results, 1);

fprintf('Accuracy = %f\n', accuracy);
fprintf('Sensitivity = %f\n', sensitivity);
fprintf('Precision = %f\n', precision);
fprintf('Specifity = %f\n', specifity);
fprintf('FMeasure = %f\n', fMeasure);
fprintf('FalseAlarmRate = %f\n', falseAlarmRate);

end