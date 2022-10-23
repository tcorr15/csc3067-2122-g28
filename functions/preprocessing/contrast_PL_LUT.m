function Lut = contrast_PL_LUT(gamma)
    Lut = (1:256);
    for index=1:256
       Lut(index) = (index.^gamma)./(255.^(gamma-1)); 
    end
end