clear all
close all
addpath (".\SVM-KM\");
addpath (".\images\");
addpath (".\images\pos\");
addpath (".\images\neg\");
addpath (".\pedestrian\");
addpath ("functions\");
addpath (".\functions\preprocessing");

%% definition of parameters
classifer = "HOG"; %if blank image passed
sample = 1; %optional sample value (1 == off)
results = [];
svmThreshold = 0.5;
nmsThreshold = 0.9;

%set up video file for capture
vidObj = VideoWriter('result.avi');
open(vidObj);
MAP=colormap(gray(256));

%define varibales for siding window 
samplingX=[320, 240, 160, 107, 80, 40];
samplingY=[192, 144, 96, 64, 48, 34];
[rows, sampleSize] = size(samplingX);
spacingx = 30; spacingy = 26; %spacing between each window (= 75% of smallest window size [matches NMS])

%define varibales for video file
vidObj = VideoWriter('result.avi');
open(vidObj);
MAP=colormap(gray(256));

%% load database
[images, fileName, labels, BBs] = loadDatabase('test.dataset', sample);
labelsCount = 1;
fprintf('Loaded Database\n');

%% Training
if isfile("Model.mat")
     load("Model.mat", "svm_Model");
     fprintf('Loaded SVM Model\n');
else
     %Create feature matrix, extract labels
    [feature_matrix, labels] = trainingFunction('pedestrian_train.cdataset', classifer);
    fprintf('created feature matrix, extracted labels\n');
    
    %Create SVM Model
    svm_Model = SVMtraining(feature_matrix, labels);
    fprintf('created SVM Model\n');
    save("Model.mat", "svm_Model");
end

%% Implementation of a simplified sliding window
for i=1:size(images,1) %for each image
    I = images(i,1:size(images,2));
    I = reshape(I, [480 640]);
    Objects = [];
    for sample_size=1:sampleSize
        for r=1:spacingy:size(I,1)
             for c= 1:spacingx:size(I,2)
                if (c+samplingY(sample_size)-1 <= size(I,2)) && (r+samplingX(sample_size)-1 <= size(I,1))

                    image = I(r:r+samplingX(sample_size)-1, c:c+samplingY(sample_size)-1); %we crop the image
                    image = imresize(image, [160 96]); %resize to model image size 
                    %imshow(image); %display image
                    feature = hog_feature_vector(image); %put the image through feature extraction

                    prediction = SVMTesting(feature,svm_Model);

                    if prediction > svmThreshold
                        %imshow(image); %display image
                        object = [r c samplingX(sample_size) samplingY(sample_size) prediction];
                        Objects = [Objects;object];
                    end
                end
             end
        end
    end
   %% NMS and plot bounding boxes
   Object_NMS = simpleNMS(Objects, nmsThreshold); 
   
   % apply bounding boxes to image
   OutputI = drawBB(I, Object_NMS);

   % Writes frame to video
   frame = im2frame(uint8(OutputI*255), MAP);
   writeVideo(vidObj,frame); 
    
   %% Evaluation of indavidual image
   [accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate] = evaluateBBs(labels(i), labelsCount, BBs, Object_NMS);
   labelsCount = labelsCount + labels(i);

   %record results
   result = [fileName(i), labels(i), size(Object_NMS, 1), accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate];
   results = [results; result];

   fprintf('Completed image - %f\n', i);
end
fprintf('Completed all images\n');

%% Evaluation of entire dataset
[accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate] = evaluateDataset(results);
result = ["mean", "", "", accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate];
results = [results; result];
save("results", "results");

%% finish and open resulting video file
close(vidObj);
implay('result.avi')