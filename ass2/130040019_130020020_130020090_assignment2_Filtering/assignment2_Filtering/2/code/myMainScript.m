%% MyMainScript

tic;
%% Your code here
%%myBilateralFilter
src1 = load('../data/barbara.mat');
src1 = src1.imageOrig;
[m,n] = size(src1);

maxInt = max(max(src1));
minInt = min(min(src1));
sigmaNoise = 0.05 * (maxInt - minInt);
rng(1);
noiseGauss = random('Normal',0,sigmaNoise, m,n);
noisy = src1 + noiseGauss;
%original image
figure
imshow(mat2gray(src1));colorbar(); axis on; title('Original');impixelinfo();
%noisy image
figure
imshow(mat2gray(noisy));colorbar(); axis on; title('Noisy');impixelinfo();

sigmaSpace = 1.56;
sigmaIntensity = 9.85;
s1 = 'sigma space = ';
s2 = 'sigma intensity = ';

rmsd = zeros(5);

spaceArray = sigmaSpace*[1,0.9,1.1,1,1];
intensityArray = sigmaIntensity*[1,1,1,0.9,1.1];

for i=1:5
bilateralFiltered = myBilateralFiltering(noisy, 27, spaceArray(i), intensityArray(i));

rmsd(i) = sqrt(abs(mean(mean((bilateralFiltered - src1).^2))));




disp(strcat(s1,num2str(spaceArray(i)),' ;',s2, num2str(intensityArray(i))));
%rmsd value
disp(strcat('rmsd value = ' ,num2str(rmsd(i))));
%filtered image
figure
imshow(mat2gray(bilateralFiltered));colorbar(); axis on; title(strcat('Bilateral Filtered for sigma space = ',num2str(spaceArray(i)),';sigma intensity = ',num2str(intensityArray(i))));impixelinfo();
end
toc;
