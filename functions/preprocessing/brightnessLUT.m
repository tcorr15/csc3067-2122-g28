function Lut = brightnessLUT(c)
    Lut = (uint32(1):uint32(256));
    for index=1:256
        if index < -c
            Lut(index) = 0;
        elseif index > 255 - c
            Lut(index) = 255;
        else
            Lut(index) = Lut(index) + c;
        end
    end
end
