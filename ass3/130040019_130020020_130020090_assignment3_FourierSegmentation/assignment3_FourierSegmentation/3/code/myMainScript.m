%% MyMainScript

tic;
%% Your code here

[src,map] = imread('../data/baboonColor.png');

%ideal values: sigma_space = 15, sigma_intensity = 30, 
%no. of iterations = 20, no. of neigbours = 100

dest = myMeanShiftSegmentation (src, 50,50,50,100);

figure
imshow(mat2gray(src));colorbar();axis on; title('original');impixelinfo();
figure
imshow(mat2gray(dest));colorbar();axis on; title('Segmented');impixelinfo();


toc;
