function h = myHistogram(I)
    h = zeros(1, 256);
    [rows, columns] = size(I);
    for row=1:rows
        for col=1:columns
            h(1, I(row, col)+1) = h(1, I(row, col)+1) + 1;
        end
    end
end