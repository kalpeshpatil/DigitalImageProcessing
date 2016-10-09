function [ dest] = myPatchBasedFiltering(src, patchSize, windowSize, sigma, sigmaPatch)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(src);
    N = (windowSize - 1)/2;
    D = (patchSize-1)/2;
    dest = zeros(m,n);
      gaussianFilter = fspecial('gaussian', patchSize, sigmaPatch);
      
    for i = 1: m
        for j = 1:n
            iWinMin = max(i-N,1);
            iWinMax = min(i+N,m);
            jWinMin = max(j-N,1);
            jWinMax = min(j+N,n);
            
            window = src(iWinMin:iWinMax , jWinMin:jWinMax);
            [windowX, windowY] = size(window);
            
            selfMinX = max(i-D,1);
            selfMaxX = min(i+D,m);
            selfMinY = max(j-D,1);
            selfMaxY = min(j+D,n);
            selfPatch = src(selfMinX:selfMaxX, selfMinY:selfMaxY);
          
            [selfX, selfY] = size(selfPatch);
             
            wt = zeros(windowX, windowY);
           
            for k = 1:windowX
                for l=1:windowY
                    kPatchMin = max(k-D,1);
                    kPatchMax = min(k+D,windowX);
                    lPatchMin = max(l-D, 1);
                    lPatchMax = min(l+D, windowY);
                    
                    patch = window(kPatchMin:kPatchMax, lPatchMin:lPatchMax);
                    
                    [patchX, patchY]=size(patch);
                    
                    
                   croppedPatch = patch(1:min(patchX,selfX),1:min(patchY,selfY)); 
                  croppedGaussian = gaussianFilter(1:min(patchX,selfX),1:min(patchY,selfY));
                   croppedSelfPatch = selfPatch(1:min(patchX,selfX), 1:min(patchY, selfY));
                    
                    
                    
                   dL = (croppedPatch - croppedSelfPatch).*croppedGaussian;
                     %dL = (croppedPatch - croppedSelfPatch);
%                     wt = exp(-(dL.^2)/(2*sigma^2));
%                     wtsum = sum(sum(wt));
                    wt(k,l) = sum(sum(dL.^2))/(size(dL,1)*size(dL,2));
                end
            end
            wt = exp(-wt/(sigma^2));
            wt = wt/sum(sum(wt));
            
            dest(i,j) = sum(sum(wt.*window));
         
        end
       
    end
                                        
            
            
            
         
            

end

