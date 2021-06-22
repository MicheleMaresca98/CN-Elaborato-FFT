%   In realtà in Matlab esiste il comando DFT, o, ancora più efficiente fft
%   che permette di calcolare la trasformata di fourier discreta su N punti
%   in modo veloce.
%   Facciamo variare N cosi noteremo le caratteristiche della trasformata,  
%   cambiando il numero di campioni avremo una migliore rappresentazione 
%   poichè il segnale è lo stesso e varia solo la frequenza di 
%   campionamento.

close all;clear all;clc;


x=zeros(10);
L=4;
x(1:L)=1;                                                                 % Impulso rettangolare di durata L

%   Analogamente l'impulso rettangolare di durata L si può fare con:
%   x=boxcar(L);

figure;stem(x);title('Segnale');

for N=4:8:36                                                              %   parte da 4 e arriva fino a 36 aumentando di 8
    X=fft(x,N);                                                           %   Trasformata di fourier discreta con N punti
    %   x=ifft(X);                                                        %   per calcolare l'inversa
    X=fftshift(X);
    v=-0.5:1/N:0.5-1/N;
    figure;stem(v,abs(X));xlim([-0.5 0.5]);
    title(sprintf('Trasformata su %d punti \n',N));
end
