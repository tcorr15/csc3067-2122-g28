function [feature_matrix, labels] = trainingFunction(filename, classifer, sampling)
if nargin<3
    sampling =1;
end

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

feature_matrix=[];
labels =[];
line1=fgetl(fp);
line2=fgetl(fp);
numberOfImages = fscanf(fp,'%d',1);

for im=1:sampling:numberOfImages

    label = fscanf(fp,'%d',1);
    labels= [labels; label];
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

    feature_matrix = [feature_matrix; feature];

    if mod(im,100) == 0
        fprintf('training image%f\n', im);
    end
end
fclose(fp);
end
