function Iout = enhanceContrastHE(Iin)
    Iout = Iin;
    Lut = contrast_HE_LUT(Iin);
    [rows, columns] = size(Iin);
    for row=1:rows
        for col=1:columns
            Iout(row, col) = Lut(Iin(row, col)+1);
        end
    end
end