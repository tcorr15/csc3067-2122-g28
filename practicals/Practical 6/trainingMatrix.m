function matrix = trainingMatrix(filename, sampling)
if nargin<2
    sampling =1;
end
    matrix=[];
    fp = fopen(filename, 'rb');
    assert(fp ~= -1, ['Could not open ', filename, '']);
    line1=fgetl(fp);
    numberOfImages = fscanf(fp,'%d',1);
    for im=1:sampling:numberOfImages
        imfile = fscanf(fp,'%s',1);
        label = fscanf(fp,'%d',1);
        extras = fscanf(fp,'%f',ainf);
        I=imread(imfile);
        if size(I,3)>1
            I=rgb2gray(I);
        end
        feature = hog_feature_vector(I);
        matrix = [matrix; feature];
        if mod(im,10) == 0
            fprintf('training image%f\n', im);
        end
    end
    fclose(fp);
end
