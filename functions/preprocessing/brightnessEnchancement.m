 clear;
close all;

img = imread("boat256.jpg");
colormap('gray');
subplot(2, 3, 1);
image(img);


subplot(2, 3, 4);
histogram(img,'BinLimits',[0 256],'BinWidth',1);


subplot(2, 3, 2);
Lut = brightnessLUT(50);
plot(Lut);


subplot(2, 3, 3);
img_enhanced = enhanceBrightness(img, 50);
image(img_enhanced);


subplot(2, 3, 6);
histogram(img_enhanced,'BinLimits',[0 256],'BinWidth',1);