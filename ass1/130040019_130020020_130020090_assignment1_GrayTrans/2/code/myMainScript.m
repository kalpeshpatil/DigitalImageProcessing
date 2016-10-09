%% MyMainScript

tic;
%% Your code here
%%myLinearContrastStretching
[src1,map1] = imread('../data/barbara.png','png');
[src2,map2] = imread('../data/TEM.png','png');
[src3,map3,d] = imread('../data/canyon.png','png');

% src1 : 0.07 to 0.93
% src2 : 0.45 to 0.94

 linearStretched1 = myLinearContrastStretching(src1);
 linearStretched2 = myLinearContrastStretching(src2);
 lsR = myLinearContrastStretching(src3(:,:,1));
 lsG = myLinearContrastStretching(src3(:,:,2));
 lsB = myLinearContrastStretching(src3(:,:,3));
 lsrgb = cat(3,lsR,lsG,lsB);
 
 
  figure  ;
  subplot(1,2,1); imshow(src1, map1) ;title('Original');colorbar;axis on;
  subplot(1,2,2); imshow(double(linearStretched1),map1); title('linear contrast stretched');colorbar;axis on;  
  figure  ;
  subplot(1,2,1); imshow(src2, map2) ;title('Original');colorbar; axis on;
  subplot(1,2,2); imshow(double(linearStretched2),map2); title('linear contrast stretched');colorbar;axis on;
    figure  ;
  subplot(1,2,1); imshow(src3, map3) ;title('Original');colorbar; axis on;
  subplot(1,2,2); imshow(double(lsrgb/255),map3); title('linear contrast stretched');colorbar;axis on;

%myHE
HE1   = myHE(src1);
HE2   = myHE(src2);
HE3R  = myHE(src3(:,:,1));
HE3G  = myHE(src3(:,:,2));
HE3B  = myHE(src3(:,:,3));
HErgb = cat(3, HE3R, HE3G, HE3B);
  
  figure  ;
  subplot(1,2,1); imshow(src1,map1) ;title('Original');colorbar;
  subplot(1,2,2); imshow(double(HE1),map1); title('histogram equalised');colorbar;
  
  figure  ;
  subplot(1,2,1); imshow(src2,map2) ;title('Original');colorbar;
  subplot(1,2,2); imshow(double(HE2),map2); title('histogram equalised');colorbar;
  
  figure  ;
  subplot(1,2,1); imshow(src3,map3) ;title('Original');colorbar;
  subplot(1,2,2); imshow(double(HErgb/255),map3); title('histogram equalised');colorbar;


%myAHE
%change n1, n2 and n3 and optimize for the best result

n1 = 181; %n1 kam kiya to noise aata hai but i can distinctly identify
n2 = 91; %n1 badhaya to Hist Equ weak hoga but noise rahega
n3 = 161; %15 pe noise --- 50 60 pe good image -- odd daal na hai !!

AHE1 = myAHE(src1,n1);

AHE2 = myAHE(src2,n2);
 
   figure  ;
   imshow(src1,map1) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE1/255),map1); title('AHE for n=181');colorbar;axis on;
   
   figure;
   imshow(src2,map2) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE2/255),map2); title('AHE for n=91');colorbar;axis on;
 
AHE3R = myAHE(src3(:,:,1),n3);
AHE3G = myAHE(src3(:,:,2),n3);
AHE3B = myAHE(src3(:,:,3),n3);
AHE3rgb = cat(3,AHE3R, AHE3G, AHE3B);
%    figure;
%    subplot(1,2,1);imshow(src3,map3) ;title('Original');colorbar;
%    subplot(1,2,2);imshow(double(AHE3rgb/255),map2); title('AHE');colorbar;
    figure;
    subplot(1,2,1);imshow(src3,map3) ;title('Original');colorbar;
    figure;
    imshow(double(AHE3rgb/255),map2); title('AHE of n=161');colorbar;

%decreased n1, n2 ,n3
%inser valus for n1, n2 and n3
n1 = 91;
n2 = 41;
n2 = 81;

AHE1 = myAHE(src1,n1);
   figure  ;
   imshow(src1,map1) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE1/255),map1); title('AHE of decreased n=91');colorbar;axis on;
   
AHE2 = myAHE(src2,n2);
   figure  ;
   imshow(src2,map2) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE2/255),map2); title('AHE of decreased n=41');colorbar;axis on;

AHE3R = myAHE(src3(:,:,1),n3);
AHE3G = myAHE(src3(:,:,2),n3);
AHE3B = myAHE(src3(:,:,3),n3);
AHE3rgb = cat(3,AHE3R, AHE3G, AHE3B);
   figure  ;
   imshow(src3,map3) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE3rgb/255),map2); title('AHE of decreased n=81');colorbar;axis on;
   
   
%%increased n1, n2 and n3  
%%insert valus for n1, n2 and n3
n1 = 251;
n2 = 161;
n3 = 231;

   AHE1 = myAHE(src1,n1);
   figure  ;
   imshow(src1,map1) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE1/255),map1); title('AHE of increased n=251');colorbar;axis on;
   
AHE2 = myAHE(src2,n2);
   figure  ;
   imshow(src2,map2) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE2/255),map2); title('AHE of increased n=161');colorbar;axis on;

AHE3R = myAHE(src3(:,:,1),n3);
AHE3G = myAHE(src3(:,:,2),n3);
AHE3B = myAHE(src3(:,:,3),n3);
AHE3rgb = cat(3,AHE3R, AHE3G, AHE3B);
   figure  ;
   imshow(src3,map3) ;title('Original');colorbar;axis on;
   figure;
   imshow(double(AHE3rgb/255),map2); title('AHE of increased n=231');colorbar;axis on;
 
%%myCLAHE
thresh1 = 0.1;% 0.01 testing saara src 2 pe karna hai
thresh2 = 0.1;
thresh3 = 0.1;
% n1 = 181;
% n2 = 91;
% n3 = 141;
CLAHE1 = myCLAHE(src1, thresh1, n1);
CLAHE2 = myCLAHE(src2, thresh2, n2);
CLAHE3R = myCLAHE(src3(:,:,1), thresh3, n3);
CLAHE3G = myCLAHE(src3(:,:,2), thresh3, n3);
CLAHE3B = myCLAHE(src3(:,:,3), thresh3, n3);
CLAHE3rgb = cat(3, CLAHE3R, CLAHE3G, CLAHE3B);
    figure  ;
    imshow(src1,map1) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE1/255),map1); title('CLAHE');colorbar;
    figure  ;
    imshow(src2,map2) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE2/255),map2); title('CLAHE');colorbar;
    figure  ;
    imshow(src3,map3) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE3/255),map3); title('CLAHE');colorbar;

thresh1 = thresh1/2;
thresh2 = thresh2/2;
thresh3 = thresh3/2;

CLAHE1 = myCLAHE(src1, thresh1, n1);
CLAHE2 = myCLAHE(src2, thresh2, n2);
CLAHE3R = myCLAHE(src3(:,:,1), thresh3, n3);
CLAHE3G = myCLAHE(src3(:,:,2), thresh3, n3);
CLAHE3B = myCLAHE(src3(:,:,3), thresh3, n3);
CLAHE3rgb = cat(3, CLAHE3R, CLAHE3G, CLAHE3B);
    figure  ;
    imshow(src1,map1) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE1/255),map1); title('CLAHE');colorbar;
    figure  ;
    imshow(src2,map2) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE2/255),map2); title('CLAHE');colorbar;
    figure  ;
    imshow(src3,map3) ;title('Original');colorbar;
    figure;
    imshow(double(CLAHE3/255),map3); title('CLAHE');colorbar;



toc;
