function [accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate] = evaluation(predictionMatrix, correctMatrix)
% This function will return all the critical evaluation metrics for
% understanding of our ML model's performance
    % Calculate noLabels
    labelClasses = unique(correctMatrix);
    [noLabels , ~] = size(labelClasses);

    % Calculate accuracy
    comparison = (correctMatrix == predictionMatrix);
    accuracy = sum(comparison)/length(comparison);
    
    % Calculate confusion matrix
    confMatrix = zeros(noLabels, noLabels);
    [rows, columns] = size(predictionMatrix);
    for row=1:rows
        for col=1:columns
            pred = predictionMatrix(row, col);
            corr = correctMatrix(row, col);
            predIndex = find(labelClasses==pred);
            corrIndex = find(labelClasses==corr);
            confMatrix(predIndex, corrIndex) = confMatrix(predIndex, corrIndex) + 1;
        end
    end
    
    % Declare the remaining metrics as zero arrays totalling number of
    % labels 
    sensitivity = zeros(noLabels, 1);
    precision = zeros(noLabels, 1);
    specifity = zeros(noLabels, 1);
    fMeasure = zeros(noLabels, 1);
    falseAlarmRate = zeros(noLabels, 1);
    
    % Loop through each label and calculate the metrics for them
    for label=1:noLabels 
        % Calculate TP, TN, FP & FN
        TP = confMatrix(label, label);
        FP = sum(confMatrix(:, label)) - confMatrix(label, label);
        FN = sum(confMatrix(label, :)) - confMatrix(label, label);
        TN = sum(confMatrix, 'all') - TP - FN - FP;
        
        % Calcluate metrics using the above values
        sensitivity(label) = TP/(TP + FN);
        precision(label) = TP /(TP+FP);
        specifity(label) = TN / (TN+FP);
        fMeasure(label) = 2 * TP / (2*TP + FN + FP);
        falseAlarmRate(label) = 1 - specifity(label);
    end  
    
end