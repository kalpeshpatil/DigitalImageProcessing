function [ dest, destfft ] = myButterworthFiltering( src, D0, n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Low pass butterworth filter

srcfft = fftshift(fft2(src));

[w, h] = size (src);

[X,Y] = meshgrid(-floor(w/2):floor((w-1)/2), -floor(h/2):floor((h-1)/2));

out = 1./(1+(((X.^2+Y.^2).^0.5)./D0).^(2*n));

figure;
imshow(mat2gray(abs(out)));colorbar();axis on; title(strcat('Butterworth mask for D0 = ',num2str(D0)));impixelinfo();


destfft = srcfft.*out;
dest = ifft2(destfft);
 
end

