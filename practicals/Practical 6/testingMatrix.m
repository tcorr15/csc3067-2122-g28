function labelMatrix = testingLabelMatrix(dataset, svmModel, featureMatrix, sampling)
if nargin<4
    sampling =1;
end
    labelMatrix = [];
    fp = fopen(dataset, 'rb');
    assert(fp ~= -1, ['Could not open ', dataset, '']);
    line1=fgetl(fp);
    line2=fgetl(fp);
    numberOfImages = fscanf(fp,'%d',1);
    for im=1:sampling:numberOfImages
        label = fscanf(fp,'%d',1);
        imfile = fscanf(fp,'%s',1);
        I=imread(imfile);
        if size(I,3)>1
            I=rgb2gray(I);
        end
        feature = hog_feature_vector(I);
        prediction = SVMTesting(feature, svmModel);
        labelMatrix = [labelMatrix; prediction];
        if mod(im,10) == 0
            fprintf('testing image%f\n', (im));
        end
    end
    fclose(fp);
end