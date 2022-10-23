function image = drawBB(image,objects)
    %draws bounding boxes onto the image
    %line_color = ['b' 'g' 'y' 'c' 'm' 'r']; %bounding box colours not
    %required for current version as its black and white
    for i = 1 : size(objects, 1)
        row1 = objects(i,1);
        row2 = objects(i,1)+objects(i,3);
        col1 = objects(i,2);
        col2 = objects(i,2)+objects(i,4);

        if col1-1 == 0 
            image(row1:row2, col1:col1+1) = 0;
        else
            image(row1:row2, col1-1:col1) = 0;
        end

        image(row1:row2, col2-1:col2) = 0;

        if row1-1 == 0
            image(row1:row1+1, col1:col2) = 0;
        else
            image(row1-1:row1, col1:col2) = 0;
        end

        image(row2-1:row2, col1:col2) = 0;
    end
end