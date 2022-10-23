function Lut = contrast_HE_LUT(Iin)
    Lut = zeros(1,256);
    
%     Calculate Iin HS
    [rows, columns] = size(Iin);
    for row=1:rows
        for col=1:columns
            Lut(Iin(row, col)+1) = Lut(Iin(row, col)+1)+1;
        end
    end
    
%     Calculate Iin CH
    cumulativeHistogram = cumsum(Lut);
    
%     Calculate Np
    noPixels = max(cumulativeHistogram)./255;
    
%     Calculate new LUT values
    for level=1:256
        Lut(level) = max([0, cumulativeHistogram(level)./noPixels - 1]);
    end
end