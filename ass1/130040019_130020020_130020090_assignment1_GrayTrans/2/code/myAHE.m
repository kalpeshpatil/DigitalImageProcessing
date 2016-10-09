function [ dest ] = myAHE( src,n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    fun = @(x)myHEm(x);
    dest = nlfilter(src,[n n],fun);

end

