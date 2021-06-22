clear;close all;clc;
%   Combinazione di due filtri.
x=double(imread('lena.jpg'));
h1=fspecial('laplacian');
h2=fspecial('gaussian',15,0.5);

P=512;Q=512;
H1=fftshift(fft2(h1,P,Q));
H2=fftshift(fft2(h2,P,Q));
H=H1.*H2;

figure(1);
subplot(1,3,1);imshow(abs(H1),[]);
subplot(1,3,2);imshow(abs(H2),[]);
subplot(1,3,3);imshow(abs(H),[]);




