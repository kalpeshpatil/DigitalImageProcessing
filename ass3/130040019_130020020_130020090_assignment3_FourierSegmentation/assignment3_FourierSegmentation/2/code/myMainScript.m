%% MyMainScript

tic;
%% Your code here
close all
src = load('../data/boat.mat');
src = src.imageOrig;

%parameters used: sigma1 = 1.5, sigma2 = 1, k = 0.07498
 dest = myHarrisCornerDetector(src,1.5,1,0.07498);

toc;
