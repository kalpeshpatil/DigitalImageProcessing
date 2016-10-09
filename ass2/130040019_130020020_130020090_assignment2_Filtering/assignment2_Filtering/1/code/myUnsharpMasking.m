function [ dest ] = myUnsharpMasking(src, N,sigma, scale)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    h = fspecial('gaussian',N, sigma);
    filtered = imfilter (src, h);
    edges = src - filtered;
    dest = src + scale*edges;
    

end

