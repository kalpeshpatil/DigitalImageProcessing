function [ shrinked ] = myShrinkImageByFactorD(src,d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   
    [m,n]=size(src);
    shrinked = zeros(m/d,n/d);
    for i = 1:1:double(m/d)
        for j = 1:1:double(n/d)
            shrinked(i,j) = src(double(i*d),double(j*d));
        end
    end
  

end

