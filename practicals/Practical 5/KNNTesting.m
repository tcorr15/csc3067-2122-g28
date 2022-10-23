function prediction = KNNTesting(testImage, modelNN, K)
[rows, columns] = size(modelNN.neighbours);
dEuc = zeros(rows,1);
for i = 1:rows
    dEuc(i)=EuclideanDistance(testImage, modelNN.neighbours(i,:));
end
[dEuc, I] = sort(dEuc);
labels = modelNN.labels(I);
labels = labels(1:K);
prediction = mode(labels(1:K));
end

