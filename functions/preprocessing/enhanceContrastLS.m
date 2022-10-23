function Iout = enhanceContrastLS(Iin, m, c)
    Iout = Iin;
    [rows, columns] = size(Iin);
    Lut = contrast_LS_LUT(m, c);
    for row=1:rows
        for col=1:columns
            Iout(row, col) = Lut(Iin(row, col)+1);
        end
    end
end