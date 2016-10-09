%% MyMainScript

tic;
%% Your code here

src1 = load('../data/superMoonCrop.mat');
src2 = load('../data/lionCrop.mat');
src1 = src1.imageOrig;
src2 = src2.imageOrig;
unsharpedMasked1 = myUnsharpMasking(src1,300,20,1.5);
src1 = imadjust(src1);
unsharpedMasked1 = imadjust(unsharpedMasked1);

 unsharpedMasked2 = myUnsharpMasking(src2,300,20,1);
 src2 = imadjust(src2);
 unsharpedMasked2 = imadjust(unsharpedMasked2);

%%parameter tuning dekh lena
figure
subplot(1,2,1);
imshow(mat2gray(src1));colorbar();axis on; title('original');impixelinfo();


subplot(1,2,2);
imshow(mat2gray(unsharpedMasked1));colorbar();axis on; title('unsharp masked');impixelinfo();

figure;
subplot(1,2,1);
imshow(mat2gray(src2));colorbar();axis on; title('original');impixelinfo();
subplot(1,2,2);
imshow(mat2gray(unsharpedMasked2));colorbar();axis on; title('unsharp masked');impixelinfo();

toc;
