%% MyMainScript

tic;
%% Your code here
%%myShrinkImage
 [src,map] = imread('../data/circles_concentric.png','png');
 shrinked2 = myShrinkImageByFactorD(src,2);
 shrinked3 = myShrinkImageByFactorD(src,3);
 figure ;
 subplot(1,3,1); imshow(src, map) ;title('Original');colorbar; axis on;
 subplot(1,3,2); imshow(shrinked2, map); title('d = 2');colorbar; axis on;
 subplot(1,3,3); imshow(shrinked3, map); title('d = 3');colorbar; axis on;
%%axes index not shown; otherwise complete
 
%%myBilinearInterpolation
 [src,map] = imread('../data/barbaraSmall.png','png');
 bilinearlyInterpolated = myBilinearInterpolation(src);
 figure;
 subplot(1,2,1); imshow(src, map);title('Original');colorbar;impixelinfo; axis on;
 subplot(1,2,2); imshow(bilinearlyInterpolated, map);daspect([2 3 1]);  title('bilinear interpolation');colorbar;impixelinfo; axis on;
%%axes index not shown; otherwise complete

%%myNearestNeighbourInterpolation
 [src,map] = imread('../data/barbaraSmall.png','png');
 NNInterpolated = myBilinearInterpolation(src);
 figure;
 subplot(1,2,1); imshow(src, map);title('Original');colorbar;impixelinfo;axis on;
 subplot(1,2,2); imshow(NNInterpolated, map);daspect([2 3 1]);  title('nearest neighbour interpolation');colorbar;impixelinfo;axis on;
  
%%axess indenx not shown
%% try to decrease spacing between images in a subplot
 
toc;