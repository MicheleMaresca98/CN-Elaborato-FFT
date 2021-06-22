%   Trasformata di Fourier per segnali bidimensionali
clear all;close all;clc;clear all;

x=double(imread('rettangolo.jpg'));
%x=imtranslate(x,[200 200]);
[M N]=size(x);
P=2*M;Q=2*N;
X=fft2(x,P,Q);% Indico con P il numero di punti lungo le righe e con Q il numero di punti lungo le colonne
Xf=fftshift(X);

v0=-0.5:1/P:(0.5-1/P);
v1=-0.5:1/Q:(0.5-1/Q);

figure(1);
subplot(1,3,1);imshow(x,[0 255]);title('Immagine');
subplot(1,3,2);imshow(log(abs(Xf)+1),[],'xdata',v1,'ydata',v0);axis('on');title('Ampiezza della trasformata');
subplot(1,3,3);imshow(angle(Xf),[],'xdata',v1,'ydata',v0);axis('on');title('Fase della trasformata');

figure(2);
[mf1,mf0]=meshgrid(v1,v0);
mesh(mf1,mf0,log(1+abs(Xf)));

x1=real(ifft2(X));
figure(3);
subplot(1,2,1);imshow(x,[0 255]);title('Immagine originale');axis('on');
subplot(1,2,2);imshow(x1,[0 255]);title('Immagine ricostruita');axis('on');

%   Traslando il rettangolo l'ampiezza della trasformata rimane la stessa
%   mentre la fase cambia



