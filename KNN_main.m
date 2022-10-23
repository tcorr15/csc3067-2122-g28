clear all
close all
addpath (".\SVM-KM\");
addpath (".\images\");
addpath (".\images\pos\");
addpath (".\images\neg\");
addpath (".\pedestrian\");
addpath ("functions\");

classifer = ""; %if blank image passed
sample = 1; %optional sample value (1 == off)
K = 1;

%% Training
%Create feature matrix, extract labels
[feature_matrix, labels] = trainingFunction('pedestrian_train.cdataset', classifer, sample);
fprintf('created feature matrix, extracted labels\n');

%Create SVM Model
KNN_Model = NNtraining(feature_matrix, labels);
fprintf('created KNN Model\n');

%% Testing
%extract labels, extract features on test images, predict label using SVM model
[predictedLabels, testLabels] = testingFunction_KNN('pedestrian_test.cdataset', KNN_Model, classifer, K, sample);
fprintf('created label matrix\n');

%% Evaluation
%Compare the predicted classification vs test labels and calculate accuracy
[Accuracy, Sensitivity, Precision, Specifity, FMeasure, FalseAlarmRate] = evaluation(predictedLabels, testLabels);
fprintf('Accuracy = %f\n', Accuracy);
fprintf('Sensitivity = %f\n', Sensitivity(2));
fprintf('Precision = %f\n', Precision(2));
fprintf('Specifity = %f\n', Specifity(2));
fprintf('FMeasure = %f\n', FMeasure(2));
fprintf('FalseAlarmRate = %f\n', FalseAlarmRate(2));