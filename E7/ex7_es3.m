% 3. Filtraggio in frequenza. Data l'immagine foto originale.jpg, si vuole 
% realizzare il filtraggio dell'immagine nel dominio della frequenza mediante
% il seguente filtro:
% Scrivete il codice relativo e mostrate l'immagine filtrata.
clear;close all;clc;

x=imread('foto_originale.tif');
figure(1);imshow(x);
x=double(x)/255;
w=rgb2hsv(x);
h=w(:,:,1);
s=w(:,:,2);
i=w(:,:,3);
[M,N]=size(i);
du=1/M;dv=1/N;
m=-1/2:du:1/2-du;
n=-1/2:dv:1/2-dv;
I=fftshift(fft2(i));
[l,k]=meshgrid(n,m);
H=(abs(l)<=0.10)&(abs(k)<=0.25);
I1=I.*H;
i1=real(ifft2(ifftshift(I1)));
w=cat(3,h,s,i1);
y=hsv2rgb(w);
figure(2);imshow(y);

% clear all; close all; clc;
% x = imread('foto_originale.tif');
% figure(1); imshow(x); title('immagine originale');
% % filtraggio nello spazio HSI
% w = rgb2hsi(x);
% I = w(:,:,3);
% [M,N] = size(I);
% du = 1/M; dv = 1/N;
% m = -1/2:du:1/2-du;
% n = -1/2:dv:1/2-dv; [k,l] = meshgrid(n,m); X=fft2(I,M,N);
% X = fftshift(X);
% H = (abs(k)<=0.10 & abs(l)<=0.25);
% Y = H.*X;
% y = real(ifft2(fftshift(Y)));
% w(:,:,3) = y;
% z = hsi2rgb(w);
% figure(2); imshow(z); title('immagine filtrata');