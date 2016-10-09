function [ ret ] = myHEm( src)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
     %[src,map] = imread(C, 'png');
    
     
      [m,n]=size(src); 
      src = double(src);
      HE = zeros(double(m),double(n));
      histArray(1:256) =0;
      cdfArray(1:256)=0;
      sum =0;
    
      
      for i = 1:1:m
          for j=1:1:n
              k=src(i,j)+1;
              histArray(k) = histArray(k)+1;
          end
      end
      
      for i=1:1:256
          sum = sum + histArray(i);
          cdfArray(i)=sum;
         % totalSum=totalSum+sum;
      end
      
      
      cdfArray = cdfArray*255/sum;
      for i = 1:1:m
          for j=1:1:n
              k = src(i,j)+1;
              HE(i,j)=(cdfArray(k))-1;
          end
      end
      
    %  subplot(1,2,1),imshow(src,map);
     % subplot(1,2,2), imshow(HE,map);
      
      ret = HE((m+1)/2,(n+1)/2);
      
      

end




