%   Se alterni il segnale i due spettri di ampiezza risultano identici
%   eccetto per una traslazione di 1/2, in particolare lo spettro
%   dell'impulso rettangolare è concentrato intorno all'orgine,
%   comportamento passa basso, mentre quello dell'impulso rettangolare
%   alternato intorno a +-1/2 ha un comportamento passa alto.
%   (.1)^n coincide con exp(j*pi*n) ovvero una traslazione dello spettro di
%   1/2 , essendo exp(j*2*pi*nio*n) una traslazione dello spettro in nio.
%   Si può concludere che cambiare il segno dei coefficienti di posto
%   dispari di un segnale è un'operazione che permette di traslare di 1/2
%   lo spettro e quindi per esempio può essere usata per trasformare un
%   filtro passabasso in un passaalto.
clear all;close all;clc;
L = 10;
N = 500;
x = [zeros(1,4) ones(1,L) zeros(1,4)];
n = [0:length(x)-1];
X = fftshift(fft(x,N));
y = x.*((-1).^n);
Y = fftshift(fft(y,N));
v = [-1/2:(1/N):1/2-1/N];
subplot(211); plot(v,abs(X)); title('impulso rettangolare'); 
subplot(212); plot(v,abs(Y)); title('impulso rettangolare alternato');