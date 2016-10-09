function [ dest ] = myHarrisCornerDetector( src, sigma1, sigma2, k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   Harris corner detector
    
    src = src / 255 ; 
    [w,h] = size(src);
    
    
    gauss1 = fspecial('gaussian',11, sigma1);
    
    smooth1 = imfilter(src, gauss1);
   
    
    [Ix, Iy] = imgradientxy(smooth1);
    
    Ix2 = Ix.*Ix;
    IxIy = Ix.*Iy;
    Iy2 = Iy.*Iy;
    
    windowSize =13;
    weights = fspecial('gaussian', windowSize, sigma2);
    Ix2avg = zeros(w,h);
    IxIyavg = zeros(w,h);
    Iy2avg = zeros(w,h);
    eigen1 = zeros(w,h);
    eigen2 = zeros(w,h);
    cornerness = zeros(w,h);
    for i = 1:w
        for j=1:h
            xmax = min(i+(windowSize-1)/2,w);
            xmin = max(i-(windowSize-1)/2,1);
            ymax = min(j+(windowSize-1)/2,h);
            ymin = max(j-(windowSize-1)/2,1);
            
            wtPatch = weights(max(1,windowSize-xmax+1):min(windowSize,w-xmin+1),max(1,windowSize-ymax+1):min(windowSize,h-ymin+1));
            wtsum = sum(sum(wtPatch));
            Ix2avg(i,j) = sum(sum(wtPatch.*Ix2(xmin:xmax, ymin:ymax)))/wtsum;
            Iy2avg(i,j) = sum(sum(wtPatch.*Iy2(xmin:xmax, ymin:ymax)))/wtsum;
            IxIyavg(i,j) =sum(sum(wtPatch.*IxIy(xmin:xmax, ymin:ymax)))/wtsum;
            
            tempMat = [Ix2avg(i,j), IxIyavg(i,j);
                        IxIyavg(i,j), Iy2avg(i,j)];
            
            e= eig(tempMat);
            eigen1(i,j) = e(1);
            eigen2(i,j) = e(2);
            
            cornerness(i,j) = e(1)*e(2) -k*(e(1)+e(2))^2;
        end
    end
    
            
            
            
            
    dest = cornerness;               
    dest2 = zeros(w,h);
    
    figure
    imshow(src);colorbar();axis on; title('original');impixelinfo();
     
    figure
    imshow(mat2gray(Ix));colorbar();axis on; title('X derivative');impixelinfo();
    figure
    imshow(mat2gray(Iy));colorbar();axis on; title('Y derivative');impixelinfo();
   
    figure
    imshow(mat2gray(eigen1));colorbar();axis on; title('first eigen value');impixelinfo();colormap('Jet');
    figure
    imshow(mat2gray(eigen2));colorbar();axis on; title('second eigen value');impixelinfo();colormap('Jet');
    figure
    imshow(50*(cornerness));colormap('Jet');colorbar();axis on;title('cornerness');impixelinfo();
    
    
    for i = 1:w
    for j=1:h
        if(dest(i,j)>0.0025)
            dest2(i,j) = 1;
        end
    end
    end
    
    
    figure
    imshow(dest2 + src);colorbar();axis on; title('corners (white spots) added to original');impixelinfo();
    
    

 

end

