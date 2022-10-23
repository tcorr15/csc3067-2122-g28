function predictedFullImage = slidingWindowHor(I, modelSVM)
    %Using previous infromation, we can calculate how tall and wide is each
    %digit
    samplingX=round(size(I,1)/numberRows);
    samplingY=round(size(I,2)/numberColumns);

    %figure
    digitCounter=0;
    map=[];

    predictedFullImage=[];
    %for each digit within the image, 
    county=0;
    for r=1:samplingX:size(I,1)
        predictedRow=[];
        county=county+1;
        countx=0;
        for c= 1:samplingY:size(I,2)
            countx=countx+1;
            maxi = [-1 -1];

            if (c+samplingY-1 <= size(I,2)) && (r+samplingX-1 <= size(I,1))

            digitCounter =digitCounter+1;

            %we crop the digit
            digitIm = I(r:r+samplingX-1, c:c+samplingY-1);

            % we convert it into doubles from 0 to 1 and invert them (rememebr that in the training set, the digitd were white on black background)
            digitIm = double(digitIm);
            digitIm = 1-(digitIm/255);


            %All training examples were 28x28. To have any chance, we need to
            %resample them into a 28x28 image
            digitIm = imresize(digitIm,[28 28]);


            %We display the individually segmented digits
            %subplot(numberRows,numberColumns,digitCounter);
            %imshow(digitIm);

            %we reshape the digit into a vector
            digitIm = preprocessDigit(digitIm);
            digitIm = reshape(digitIm, [1, (28*28)]);



            prediction = SVMTesting(digitIm,modelSVM);  

            predictedRow=[predictedRow prediction];

            w = [r; c];
            temp_maxi = 2/norm(w);
            if temp_maxi > maxi(1)
                maxi = [temp_maxi, prediction];
            end
            map(county, countx) = maxi(2);


            end
        end
        predictedFullImage=[predictedFullImage; predictedRow];
    end
end