% Initialisation of scripts, will be running through 
clear all;
close all;

addpath(".\People - Code");
addpath(".\People - Images");
addpath(".\People - Images\images");
addpath(".\People - Images\images\neg");
addpath(".\People - Images\images\pos");


%% -------------------------- Training --------------------------
% Step 1 - Load predestrian database with the train dataset
[images, labels] = loadPedestrianDatabase('pedestrian_train.cdataset');

% Step 2,3,4 - Create a feature matrix of the feature vectors for each
% image
feature_matrix = featureMatrix("pedestrian_train.cdataset");

% Step 5 - train an SVM model with the feature matrix and labels column
% vector
svm_Model = SVMtraining(feature_matrix, labels);

% Step 6 - Display the learned model with showHog for visualisation
% (INCOMPETE)
% svm_Matrix = displaySVMModel(svm_Model.xsup, svm_Model.w);
% showHog(svm_Matrix);



%% -------------------------- Testing --------------------------
% Step 7 -  Load testing images and extract HOG features, predict label for
% them given by SVM and the previously trained model
[imagesTest, labelsTest] = loadPedestrianDatabase('pedestrian_test.cdataset');
testingLabels = featureLabelMatrix("pedestrian_test.cdataset", svm_Model, feature_matrix);

% Step 8 - Calculate the accuracy by comparing the labelsTest and
% testingLabels
classificationResult = (labelsTest(1:50, :) == testingLabels);
accuracy = sum(classificationResult)/length(classificationResult)

