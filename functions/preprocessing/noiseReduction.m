function Iout = noiseReduction(I, N)
    mask = (1./(N.*N))*ones(N, N);
    Iout = conv2(I, mask);
end