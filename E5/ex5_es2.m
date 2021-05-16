close all; clear all; clc;
x = double(imread('volto.tif'));
X = fft2(x);
Xf = fftshift(X);
figure(1);
Z = log(1+abs(Xf)); % enhancement per visualizzazione
subplot(121); imshow(Z,[]); title('Spettro di ampiezza');
subplot(122); imshow(angle(Xf),[]); title('Spettro di fase');
ym = real(ifft2(abs(X))); % ricostruzione solo modulo
yf = real(ifft2(exp(i*angle(X)))); % ricostruzione solo fase
figure(2);
z = log(ym-min(ym(:))+1); % enhancement per la visualizzazione
subplot(121); imshow(z,[]);
title('Ricostruzione spettro di ampiezza');
subplot(122); imshow(yf,[]);
title('Ricostruzione spettro di fase');