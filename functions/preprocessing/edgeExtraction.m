function [Edges, Ihor, Iver] = edgeExtraction(Iin, B1, B2)
    Iver = myconvolution(Iin, B1);
    Ihor = myconvolution(Iin, B2);
    Edges = sqrt(Iver.^2+Ihor.^2);
end