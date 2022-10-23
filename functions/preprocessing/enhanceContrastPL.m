function Iout = enhanceContrastPL(Iin, gamma)
    Iout = Iin;
    [rows, columns] = size(Iin);
    Lut = contrast_PL_LUT(gamma);
    for row=1:rows
        for col=1:columns
           Iout(row, col) = Lut(Iout(row, col)+1);
        end
    end
end
