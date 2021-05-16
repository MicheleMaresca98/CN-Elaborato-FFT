%   Filtraggio immagine a colori
clear;close all;clc;
x=imread('fiori.jpg');
x=double(x)/255;
R=x(:,:,1);
G=x(:,:,2);
B=x(:,:,3);
figure(1);imshow(x);title('Immagine a colori');
h=[-1 -1 -1;-1 9 -1;-1 -1 -1];

y=imfilter(x,h);
figure(2);
imshow(y);title('img. filtraggio in RGB');

w=rgb2ycbcr(x);
I=w(:,:,1);
Cb=w(:,:,2);
Cr=w(:,:,3);
I=imfilter(I,h);
w=cat(3,I,Cb,Cr);
y2=ycbcr2rgb(w);
figure(3);
imshow(y2);
title('img. filtraggio solo di I');