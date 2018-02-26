clc
clear
close all
img = imread('phanton_with_noise.tif');
% subplot(2,2,1)
figure(1)
imagesc(img); colormap(gray);
% title('original','FontSize',9)
F = fftshift(fft2(ifftshift(img)));
% subplot(2,2,2)
figure(2)
FT = abs(F);
FT = log(FT+1);
% FT(512,512) = 0;
% FT(513,513) = 0;
imagesc(FT);colormap(gray);
% imwrite(FT,'fourier.jpg');
% title('Fourier Transform','FontSize',9)

% [x,y] = size(F);
% nb_points = (x/64) * (y/64);

% a1=1; %?
% a2=1; %?
% a3=1; %?
% 
% b1 = 2*pi*((a2*a3)/(a1*(a2*a3)));
% b2 = 2*pi*((a3*a1)/(a2*(a3*a1)));
% b3 = 2*pi*((a1*a2)/(a3*(a1*a2)));
% 
% G = m1*b1+m2*b2+m3*b3;

% FC=ifft2(F);
% subplot(2,2,3)
% imshow(uint8(FC))
% title('Inverse Fourier','FontSize',9)