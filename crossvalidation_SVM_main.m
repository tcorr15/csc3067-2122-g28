clear all
close all
addpath (".\SVM-KM\");
addpath (".\images\");
addpath (".\images\pos\");
addpath (".\images\neg\");
addpath (".\pedestrian\");
addpath ("functions\");
addpath (".\functions\preprocessing");
addpath ("cross-validation\")

classifer = ""; %if blank image passed
sample = 1; %optional sample value (1 == off)

%% Training
%Create feature matrixs, extract labels
[feature_matrix1, labels1] = trainingFunction('train1.cdataset', classifer, sample);
[feature_matrix2, labels2] = trainingFunction('train2.cdataset', classifer, sample);
[feature_matrix3, labels3] = trainingFunction('train3.cdataset', classifer, sample);
fprintf('created feature matrixs, extracted labels\n');

%Create SVM Models
svm_Model1 = SVMtraining(feature_matrix1, labels1);
svm_Model2 = SVMtraining(feature_matrix2, labels2);
svm_Model3 = SVMtraining(feature_matrix3, labels3);
fprintf('created SVM Models\n');

%% Testing
%extract labels, extract features on test images, predict label using SVM model
[predictedLabels1, testLabels1] = testingFunction_SVM('test1.cdataset', svm_Model1, classifer, sample);
[predictedLabels2, testLabels2] = testingFunction_SVM('test2.cdataset', svm_Model2, classifer, sample);
[predictedLabels3, testLabels3] = testingFunction_SVM('test3.cdataset', svm_Model3, classifer, sample);
fprintf('testing complete\n');

%% Evaluation
%Compare the predicted classification vs test labels and calculate accuracy
[Accuracy1, Sensitivity1, Precision1, Specifity1, FMeasure1, FalseAlarmRate1] = evaluation(predictedLabels1, testLabels1);
fprintf('\nSet1\nAccuracy = %f\n', Accuracy1);
fprintf('Sensitivity = %f\n', Sensitivity1(2));
fprintf('Precision = %f\n', Precision1(2));
fprintf('Specifity = %f\n', Specifity1(2));
fprintf('FMeasure = %f\n', FMeasure1(2));
fprintf('FalseAlarmRate = %f\n', FalseAlarmRate1(2));
[Accuracy2, Sensitivity2, Precision2, Specifity2, FMeasure2, FalseAlarmRate2] = evaluation(predictedLabels2, testLabels2);
fprintf('\nSet2\nAccuracy = %f\n', Accuracy2);
fprintf('Sensitivity = %f\n', Sensitivity2(2));
fprintf('Precision = %f\n', Precision2(2));
fprintf('Specifity = %f\n', Specifity2(2));
fprintf('FMeasure = %f\n', FMeasure2(2));
fprintf('FalseAlarmRate = %f\n', FalseAlarmRate2(2));
[Accuracy3, Sensitivity3, Precision3, Specifity3, FMeasure3, FalseAlarmRate3] = evaluation(predictedLabels3, testLabels3);
fprintf('\nSet3\nAccuracy = %f\n', Accuracy3);
fprintf('Sensitivity = %f\n', Sensitivity3(2));
fprintf('Precision = %f\n', Precision3(2));
fprintf('Specifity = %f\n', Specifity3(2));
fprintf('FMeasure = %f\n', FMeasure3(2));
fprintf('FalseAlarmRate = %f\n', FalseAlarmRate3(2));

crossValidationAccuracy = (Accuracy1 + Accuracy2 + Accuracy3) ./ 3;
fprintf('Cross Validation Accuracy = %f\n', crossValidationAccuracy.*100);