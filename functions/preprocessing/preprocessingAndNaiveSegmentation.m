clear all;
close all;

img = imread("vehicle.jpg");
 
subplot(3, 2, 1);
imagesc(img), colormap('gray'), axis off;
title("Original");

% subplot(3, 2, 2);
% histogram(img, 'BinLimits', [0, 256], 'BinWidth', 1);

% Apply Contrast Enhancement
imgEnhanced = enhanceContrastALS(img);

% Apply Histogram Equalisation
imgEnhanced = enhanceContrastHE(imgEnhanced);

% Apply Power Law
imgEnhanced = enhanceContrastPL(imgEnhanced, 0.5);

% Apply Convolution & Noise Filtering
imgEnhanced = noiseReduction(imgEnhanced, 3);


subplot(3, 2, 2);
imagesc(imgEnhanced), colormap('gray'), axis off;
title("Pre-Processed");

subplot(3, 2, 4);
imgEnhanced = round(imgEnhanced);
h = myHistogram(round(imgEnhanced));
histogram(h, 256);
