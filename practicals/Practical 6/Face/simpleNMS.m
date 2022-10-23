function Objects = simpleNMS(Objects,threshold)

% object contains data: x,y,width,height
% for every detected_bounding_box:
%   calculate the intersection_area with any other detected_bounding_box
%   if (intersection_area / bounding_box_area ) is > threshold
%       remove one of the intersecting bounding box (the one with smaller confidence)
%   end
% end

if(~isempty(Objects))
    for i=1:size(Objects,1)
        for j=1:size(Objects,1)
            if (i ~= j)
                intersection_area = rectint(Objects(i,1:4),Objects(j,1:4)); 
                bounding_box_area = Objects(i,3) .* Objects(i,4); 
                if (intersection_area/bounding_box_area) > threshold 
                    if Objects(i,5) > Objects(j,1:5)
                        Objects(j,1:4) = 0;
                    else
                        Objects(i,1:4) = 0;
                    end
                end
            end
        end
    end
end

end