function [ dest ] = myCLAHE( src, thold, n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    fun = @(x)myHECLAHE(x, thold);
    dest = nlfilter(src,[n n],fun);
    
end

