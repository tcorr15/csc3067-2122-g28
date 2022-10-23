function Iout = enhanceContrastALS(Iin)
    I1 = min(Iin,[],'all')+1;
    I2 = max(Iin, [],'all')+1;
    m = double(255./double(I2 - I1));
    c = -double(m).*double(I1);
    Iout = enhanceContrastLS(Iin, m, c);
end