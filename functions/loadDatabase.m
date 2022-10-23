function [images, fileName, labels, BBs] = loadDatabase(filename, sampling)

if nargin<2
    sampling =1;
end

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

line1=fgetl(fp);
numberOfImages = fscanf(fp,'%d',1);
images=[];
fileName=[];
labels=[];
BBs=[];

for im=1:sampling:numberOfImages
    objects=[];
    imfile = fscanf(fp,'%s',1);
    fileName=[fileName; convertCharsToStrings(imfile)];
    I=imread(imfile);
    if size(I,3)>1
        I=rgb2gray(I);
    end
    vector = reshape(I,1, size(I, 1) * size(I, 2));
    vector = double(vector)/255;
    images= [images; vector];

    label = fscanf(fp,'%d',1);
    labels = [labels; label];

    for i=1:label
        x = fscanf(fp,'%f',1);
        y = fscanf(fp,'%f',1);
        width = fscanf(fp,'%f',1);
        height = fscanf(fp,'%f',1);
        extra = fscanf(fp,'%f',1);
        object = [x y width height extra];
        objects = [objects;object];
    end
   
    BBs = [BBs; objects];
end
fclose(fp);
end