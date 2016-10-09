%% MyMainScript

tic;
%% Your code here
%
%%
% *myPatchBasedFiltering*
%%
%note: we have resized image to 1/4th of original size (instead of 1/2)
%as mentioned in problem statement to make our code run fast
%Therefore window size and patchsize are also halved [13*13 and 5*5]
%in order to maintain consistancy. The parameters are found accordingly
src1 = load('../data/barbara.mat');
src1 = src1.imageOrig;
src1 = imresize(src1, 0.25);
optimalSD = 0.275;
sd = [optimalSD, optimalSD*0.9, optimalSD*1.1];
rmsd = zeros(3);



[m,n] = size(src1);

maxInt = max(max(src1));
minInt = min(min(src1));
sigmaNoise = 0.05 * (maxInt - minInt);
rng(1);
noiseGauss = random('Normal',0,sigmaNoise, m,n);
noisy = src1 + noiseGauss;

%gaussian mask
gaussianFilter = fspecial('gaussian', 13, 1.66);
 disp('Gaussian mask used for spatial filtering')
 imshow(mat2gray(gaussianFilter),'InitialMagnification',2000);colorbar();axis on; title('mask for spacial sigma = 1.66');
 
%original image
figure;
imshow(mat2gray(src1),'InitialMagnification', 300);colorbar();axis on; title('original');impixelinfo();
%corrupted image (noisy)
figure;
imshow(mat2gray(noisy),'InitialMagnification', 300);colorbar();axis on; title('noisy');impixelinfo();


 
for i=1:3
patchBasedFiltered = myPatchBasedFiltering(noisy, 5, 13, sd(i),1.66);

rmsd(i) = sqrt((mean(mean((patchBasedFiltered - src1).^2))));

%patch based filtered image

figure;
imshow(mat2gray((patchBasedFiltered)),'InitialMagnification', 300);colorbar();axis on; title(strcat('patch based filtered for sigma = ',num2str(sd(i))));impixelinfo();
%rmsd value
disp(strcat('rmsd = ', num2str(rmsd(i))));

end
  
 
toc;
