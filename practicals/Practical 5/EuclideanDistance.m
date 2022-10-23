function dEuc=EuclideanDistance(sample1, sample2)
[rows, columns] = size(sample1);
sum = 0;

for n = 1:columns
    sum = sum + (sample1(n) - sample2(n)).^2;
end
dEuc = sqrt(sum);
end

