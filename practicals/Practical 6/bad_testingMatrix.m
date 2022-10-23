function testingLabels = bad_testingLabelMatrix(imagesTest, svm_Model)
testingLabels = [];
for im=1:size(imagesTest,1)
    image=imagesTest(im,:);
    image=imresize(image,[96 160]);
    image=hog_feature_vector(image);

    prediction = SVMTesting(image, svm_Model);
    testingLabels = [testingLabels; prediction];

    if mod(im,10) == 0
        fprintf('testing image%f\n', (im));
    end
end
    
end