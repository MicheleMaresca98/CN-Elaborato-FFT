clear all; close all; clc;

%   Capiamo se i filtri sono passa alto o basso
x = fspecial('sobel');

%   Average è un passa basso più è grande l'ampiezza maggiore sarà
%   l'attenuazione alle alte frequenze, è una rect quindi la trasformata è
%   una sinc.
%   Gaussian è un passa basso dove più è piccola la dev standard nel tempo
%   maggiore sarà la banda in frequenza
%   Sobel è un filtro passa alto e fa passare le discontinuità verticali
%   similmente alla derivata sostanzialmente
%   per lo stesso raggionamento il Laplaciano è un passa alto

P = 100;
Q = 100;
X=fft2(x,P,Q);
Xf=fftshift(X);
v0 = -0.5:1/P:(0.5-1/P);
v1 = -0.5:1/Q:(0.5-1/Q);
figure; imshow(log(abs(Xf)+1),[], "XData", v1, "YData",v0);title("Trasformata centrata"); axis on;
figure;
[l,k] = meshgrid(v1,v0);
mesh(k,l, log(abs(Xf)+1));