function [predictedLabels, testLabels] = testingFunction_SVM(dataset, svmModel, classifer, sampling)
if nargin<4
    sampling =1;
end

fp = fopen(dataset, 'rb');  
assert(fp ~= -1, ['Could not open ', dataset, '']);

predictedLabels = [];
testLabels = [];

line1=fgetl(fp);
line2=fgetl(fp);
numberOfImages = fscanf(fp,'%d',1);

for im=1:sampling:numberOfImages

    label = fscanf(fp,'%d',1);
    testLabels = [testLabels; label];
    imfile = fscanf(fp,'%s',1);
    I=imread(imfile);

    if size(I,3)>1
        I=rgb2gray(I);
    end
    
%     Pre-Processing Stage
    I = enhanceContrastALS(I);
    I = enhanceContrastPL(I, 0.5);

%     Feature Extraction Stage    
    if classifer == "HOG"
        feature = hog_feature_vector(I); % HOG
    else
        feature = reshape(double(I/255), [1, 15360]); % Feature = Image
    end

    prediction = SVMTesting_binary(feature, svmModel);
    predictedLabels = [predictedLabels; prediction];

    if mod(im,10) == 0
        fprintf('testing image%f\n', (im));
    end
end
fclose(fp);
end