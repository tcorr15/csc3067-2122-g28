function Iout = enhanceBrightness(Iin, c)
    Iout = Iin;
    [rows, columns] = size(Iin);
    Lut = brightnessLUT(c);
    for row=1:rows
        for col=1:columns
            Iout(row, col) = Lut(Iin(row, col));
        end
    end
end