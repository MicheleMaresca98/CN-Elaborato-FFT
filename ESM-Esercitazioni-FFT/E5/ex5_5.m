clear all; close all; clc;

%   Capiamo se i filtri sono passa alto o basso
x = fspecial('sobel');

%   Average � un passa basso pi� � grande l'ampiezza maggiore sar�
%   l'attenuazione alle alte frequenze, � una rect quindi la trasformata �
%   una sinc.
%   Gaussian � un passa basso dove pi� � piccola la dev standard nel tempo
%   maggiore sar� la banda in frequenza
%   Sobel � un filtro passa alto e fa passare le discontinuit� verticali
%   similmente alla derivata sostanzialmente
%   per lo stesso raggionamento il Laplaciano � un passa alto

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