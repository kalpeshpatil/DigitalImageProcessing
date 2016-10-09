function [ dest ] = myBilateralFiltering(src, windowSize, sigma_d, sigma_r )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
N = (windowSize - 1)/2; 
% Allocate memory for the output image
Len = size(src);
Out = zeros(Len);

% Pre-compute the first gaussian from the formula
[X,Y] = meshgrid(-N:N,-N:N);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

figure
imshow(mat2gray(G),'InitialMagnification', 400);colorbar(); axis on; title('Space Gaussian Mask'); impixelinfo();
% Go bilateral filter go
for i = 1:Len(1)
    
         %get the region of interest denoted with N in the text 
         iMin = max(i-N,1);
         iMax = min(i+N,Len(1));
         
   for j = 1:Len(2)
      
         
         jMin = max(j-N,1);
         jMax = min(j+N,Len(2));
         
         I = src(iMin:iMax,jMin:jMax);
      
         dL = I(:,:)-src(i,j);
         H = exp(-(dL.^2)/(2*sigma_r^2));
      
         % Calculate bilateral filter response.
         tmp = H.*G((iMin:iMax)-i+N+1,(jMin:jMax)-j+N+1);
         norm_tmp = sum(tmp(:));
         Out(i,j) = sum(sum(tmp.*I(:,:)/norm_tmp));
      
         
                
   end
end
dest = Out;


end

