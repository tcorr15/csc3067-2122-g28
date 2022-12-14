clear all 
close all 
load Yale_64x64
[nSamples, nDimensions] = size(fea); 

h=64;
w=64;
% draw the first 9 images 
% //////////STEP 4 \\\\\\\\\\\\\\\\\\\\\\

% Apply PCA
% //////////STEP 5 \\\\\\\\\\\\\\\\\\\\\\


%% show 0th through 15th principal eigenvectors 
eig0 = reshape(meanX, [h,w]); 
figure,subplot(4,4,1) 
imagesc(eig0) 
colormap gray 
for i = 1:15 
subplot(4,4,i+1) 
imagesc(reshape(eigenVectors(:,i),h,w)) 
end

%%
%animation for observing the variation of the first eigenvector
%////////////////////// STEP 7 \\\\\\\\\\\\\\\\\\\\\\\\\\

