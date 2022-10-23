function [accuracy, sensitivity, precision, specifity, fMeasure, falseAlarmRate] = evaluateBBs(labels, labelsCount, BBs, Objects)

%Compares bounding boxes from dataset to objects found in sliding window
TP=0;
TN=0; %cannot be calculated as we can have infinite sliding windows
FP=0;
FN=0;

% calculates false negatives and true positives
for i=labelsCount:(labelsCount+labels)-1
    match=0;
    for j=1:size(Objects,1)
        intersection_area = rectint(BBs(i,1:4),Objects(j,1:4)); 
        bounding_box_area = BBs(i,3) .* BBs(i,4);
        if (intersection_area/bounding_box_area) > 0.5
            match=1;
        end
    end
    if match == 0
        FN=FN+1;
    else
        TP=TP+1;
    end
end

% calculates false positives
for i=1:size(Objects,1)
    match=0;
    for j=labelsCount:(labelsCount+labels)-1
        intersection_area = rectint(Objects(i,1:4),BBs(j,1:4)); 
        bounding_box_area = Objects(i,3) .* Objects(i,4);
        if (intersection_area/bounding_box_area) > 0.5
            match=1;
        end
    end
    if match == 0
        FP=FP+1;
    end
end

accuracy = (TN+TP) / labels;
sensitivity = TP/(TP + FN);
precision = TP /(TP+FP);
specifity = TN / (TN+FP);
fMeasure = 2 * TP / (2*TP + FN + FP);
falseAlarmRate = 1 - specifity;

end