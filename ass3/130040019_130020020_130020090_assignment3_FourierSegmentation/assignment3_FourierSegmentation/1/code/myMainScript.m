%% MyMainScript

tic;
%% Your code here
%%Low pass butterworth filter
close all
src = load('../../1/data/boat.mat');
src = src.imageOrig();
[m,n] = size(src);


maxInt = max(max(src));
minInt = min(min(src));
sigmaNoise = 0.10 * (maxInt - minInt);
rng(1);
noiseGauss = random('Normal',0,sigmaNoise, m,n);
noisy = src + noiseGauss;

%original image
figure(1);
imshow(mat2gray(src));colorbar();axis on; title('original');impixelinfo();
%corrupted image (noisy)
figure(2);
imshow(mat2gray(noisy));colorbar();axis on; title('noisy');impixelinfo();

D0 = 98.5;

D0Array = [D0, 0.95*D0, 1.05*D0];
rmsd = zeros(3);

for i = 1:3
    
[dest, destfft] = myButterworthFiltering(noisy, D0Array(i), 2);

rmsd(i) = sqrt((mean(mean((mat2gray(abs(dest)) - mat2gray(src)).^2))));
figure;
imshow(mat2gray(abs(dest)));colorbar();axis on; title(strcat('Butterworth LPF for D0 = ',num2str(D0Array(i))));impixelinfo();
%rmsd value
disp(strcat('rmsd = ', num2str(rmsd(i)),' for D= ',num2str(D0Array(i))));

end
disp(' ');
%second part

%[dest, destfft] = myButterworthFiltering(noisy, D0,2);
srcfft = fftshift(fft2(src));
figure
sf = log(abs((srcfft))+1);
imshow(mat2gray(sf));colorbar();axis on; title(strcat('Log(FFT) of the output'));impixelinfo();

DCoffset = mean(mean(abs(src)));
disp('Indices in 0.5 range of DC value');
for i = 1:m
    for j = 1:n
        if(abs(abs(src(i,j))-DCoffset)<=0.5)
            disp (strcat('X: ',num2str(i),' Y: ',num2str(j)));
        end
    end
end
disp(' ');

%radius finding for given energies
srcabs = abs(srcfft);

%r,energy = 2,91  5,94  14,97.01   59,99
rArray = [2,5,14,59];
energyArray = [91,94,97,99];
rmsd2 = zeros(4);
for p=1:4
    r = rArray(p);
    [x, y] = meshgrid(-r:r, -r:r);
    maskR = (x.^2+y.^2<=r^2);
    weightedMask = maskR.*srcfft(m/2-r:m/2+r,n/2-r:n/2+r);
    energy = sum(sum(abs(weightedMask.^2)))/(sum(sum(srcabs.^2)));
    srcModFFT = zeros(m,n);
    for i=1:2*r+1
        for j=1:2*r+1
            if (maskR(i,j) == 1)
                srcModFFT(m/2+i-r-1,n/2+j-r-1) = weightedMask(i,j);
            end
        end
    end
    srcR = ifft2(srcModFFT);
    figure
    imshow(mat2gray(abs(srcR)));colorbar();axis on; title(strcat('reconstructed',' ',num2str(energyArray(p)),'% energy circular patch'));impixelinfo();
    rmsd2(p) = sqrt((mean(mean(mat2gray(abs(srcR)) - mat2gray(abs(src))).^2)));
    disp(strcat('Energy: ',num2str(energyArray(p)),'%, Radius: ',num2str(rArray(p))));
    disp(strcat('Corresponding RMSD: ',num2str(rmsd2(p))));
    disp(' ');
    
end
toc;
