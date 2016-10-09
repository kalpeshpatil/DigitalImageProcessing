function [interpolated] = myNearestNeighborInterpolation(src)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
   
      [m,n]=size(src); 
      src = 255*im2double(src);
      interpolated = zeros(double(3*m-2), double(2*n-1));
       flagM=1; 
      for i = 1:1:m
          flagN = 1;
          if i==m  
                  flagM = 0;
              end
          for j = 1:1:n
                  
              if j==n
                  flagN=0;
              end   
             interpolated(3*i-2,2*j-1)=src(i,j);
             if flagN 
                 interpolated (3*i-2,2*j)=(src(i,j)+src(i,j+1))/2;end
             if flagM 
                 interpolated(3*i-1,2*j-1)=src(i,j);end
             if flagN && flagM 
                 interpolated(3*i-1,2*j)=(src(i,j)+src(i,j+1))/2;end
             if flagM 
                 interpolated(3*i,2*j-1)=src(i+1,j);end
             if flagM && flagN 
                 interpolated(3*i,2*j)=(src(i+1,j)+src(i+1,j+1))/2;end
              
              
              
          end
      end
     

              


end

