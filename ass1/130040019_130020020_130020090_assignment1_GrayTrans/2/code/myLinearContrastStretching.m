function [linearStretched] = myLinearContrastStretching(src)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    minSrc = double(min(min(src)));
    maxSrc = double(max(max(src)));
    [m,n] = size(src);
    linearStretched = zeros(m,n);
   
    
       
            linearStretched = 255*(double(src) - minSrc)/(maxSrc - minSrc);
       
    
    
    

end

