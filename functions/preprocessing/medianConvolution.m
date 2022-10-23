function Iout = medianConvolution(Iin,B)

    Iin=double(Iin);
    B=double(B);
    [M, N] = size(B);

    %Task1 Step 5
    Iout = zeros(size(Iin)-size(B)+1);
    [rows, columns] = size(Iout);

    for l=1:rows
       for k=1:columns
           selectedMask = zeros(M, N);
           for i=k:k+N-1
               for j=l:l+M-1
                   selectedMask(j-l+1, i-k+1) = Iin(j, i)*B(j-l+1, i-k+1);
               end
           end

           Iout(l, k) = median(selectedMask, 'all');
       end
    end