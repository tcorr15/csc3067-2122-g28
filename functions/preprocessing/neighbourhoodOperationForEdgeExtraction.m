clear all;
close all;

Iin = imread("boatnois.jpg");
B1 = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
B2 = [-1, -1, -1; 0, 0, 0; 1, 1, 1];

[Edges Ihor, Iver] = edgeExtraction(Iin, B1, B2);

subplot(2, 2, 1);
imagesc(Edges), colormap('gray');
axis off;

subplot(2, 2, 3);
histogram(Edges, 'BinLimits', [0, 256], 'BinWidth', 1);