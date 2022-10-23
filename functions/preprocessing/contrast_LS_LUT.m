function Lut = contrast_LS_LUT(m, c)
    Lut = (1:256);
    for index=1:256
        Lut(index) = m*Lut(index) + c;
    end
end
