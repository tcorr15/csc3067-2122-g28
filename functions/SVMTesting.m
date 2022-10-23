function [prediction maxi]= SVMTesting(image,model)

if strcmp(model.type,'binary')
    
    kerneloption.matrix=svmkernel(image,'poly',model.param.sigmakernel,model.xsup);
    pred = svmval(image,model.xsup,model.w,model.w0,model.param.kernel,kerneloption);
    
    %pred = svmval(image,model.xsup,model.w,model.w0,model.param.kernel,model.param.kerneloption);
    
    if pred>0
        prediction = pred;
    else
        prediction = 0; %-1
    end
    
else
    
    [pred maxi] = svmmultival(image,model.xsup,model.w,model.b,model.nbsv,model.param.kernel,model.param.kerneloption);

     prediction = round(pred)-1;
    
end
    
end