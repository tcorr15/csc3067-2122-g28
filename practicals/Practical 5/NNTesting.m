function prediction = NNTesting(testImage, modelNN)

[rows, columns] = size(modelNN.neighbours);

result = Inf;

for i = 1:rows
    dEuc=EuclideanDistance(testImage, modelNN.neighbours(i,:));
    if result > dEuc
        result = dEuc;
        index = i;
    end
end
prediction = modelNN.labels(index);
end

