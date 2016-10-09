function [ dest ] = myMeanShiftSegmentation(src, sigma_space, sigma_int, nIter, nNeighbour )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %smoothening
    src = mat2gray(src);
    %undersampling for computation
    src = imresize(src, 0.5);
    Size = size(src);
    w = Size(1);
    h = Size(2);
    dest = zeros(w,h);
    
    %5 dimensional space consisting of observations for knn search
    nPoints = w*h;
    points5d = zeros(5, nPoints);
    
    for i = 1:w
        for j = 1:h
            points5d (:,(i-1)*h + j) = [i,j,src(i,j,1),src(i,j,2),src(i,j,3)];
        end
    end
    
    %scaling by respective sigmas
    scaled5d = points5d';
    scaled5d(:,1:2)=scaled5d(:,1:2)/(1.414*sigma_space);
    scaled5d(:,3:5)=scaled5d(:,3:5)*255/(1.414*sigma_int);
    
    tempOP = scaled5d;
    
    for itr = 1:nIter
        [ID, dist] = knnsearch(scaled5d,scaled5d,'k',nNeighbour);
        
        for i = 1:nPoints
            wts = exp(-(dist(i,:).^2));
            wtSum = sum(wts);
            wts = wts';
            wts = [wts, wts, wts];
            tempOP(i, 3:5) = sum(wts.*(tempOP(ID(i,:),3:5)))/wtSum;
        end
    end
    
    %output from 5d space
    for i=1:w
        for j=1:h
            dest(i,j,1) = tempOP((i-1)*h+j,3);
            dest(i,j,2) = tempOP((i-1)*h+j,4);
            dest(i,j,3) = tempOP((i-1)*h+j,5);
        end
    end
    dest = imresize(dest, 2);
end

