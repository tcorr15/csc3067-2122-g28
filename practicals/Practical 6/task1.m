%clear all
%close all
addpath (".\People - Code\");
addpath (".\People - Code\SVM-KM\");
addpath (".\People - Images\");
addpath (".\People - Images\images\");
addpath (".\People - Images\images\pos");
addpath (".\People - Images\images\neg");

%optional sample value (=1 == off)
sample = 1;

%% Training
%step 1 - load training database
[images, labels] = loadPedestrianDatabase('pedestrian_train.cdataset', sample);
fprintf('loaded training database\n');

%step 2 - 4 create feature matrix
feature_matrix = trainingMatrix('pedestrian_train.cdataset', sample);
fprintf('created feature matrix\n');

%step 5 - Train SVM Model
svm_Model = SVMtraining(feature_matrix, labels);
fprintf('created SVM Model\n');

%% Testing
%step 7 - load testing database
[imagesTest, labelsTest] = loadPedestrianDatabase('pedestrian_test.cdataset', sample);
fprintf('loaded testing database\n');

%extract features, predict label, Test SVM Model
testingLabels = testingMatrix('pedestrian_test.cdataset', svm_Model, feature_matrix, sample);
fprintf('created label matrix\n');

%% Evaluation
%step 8 - Compare the predicted classification vs test labels and calculate accuracy
comparison = (labelsTest == testingLabels);
Accuracy = sum(comparison)/length(comparison);
fprintf('Accuracy = %f\n', Accuracy.*100);
