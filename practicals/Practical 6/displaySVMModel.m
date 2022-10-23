function outputVector = displaySVMModel(xsup, w)
    outputVector = [];
    [rows, columns] = size(xsup);
    for row=1:rows
        weight = w(row, 1);
        weightSum = 0;
        for col=1:columns
            weightSum = weightSum + (weight*xsup(row,col));
        end
        outputVector = [outputVector; weightSum];
    end
end