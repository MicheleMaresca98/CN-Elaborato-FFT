clear;close all;clc;
%   Esempio di filtraggio nel dominio di Fourier per segnali
%   monodimensionali

%   Convoluzione tra due segnali monodimensionali
x=[1 2 3 4 5];
tx=0:4;
h=[1 1 1];
th=0:2;

y=conv(x,h);
ty=0:numel(y)-1;



%   Convoluzione in frequenza
M=numel(x);
X=fft(x,M);
H=fft(h,M);
Y=X.*H;
y1=real(ifft(Y));
ty1=0:numel(y1)-1;
figure(1);
subplot(4,1,1);stem(tx,x);xlim([-2,8]);
subplot(4,1,2);stem(th,h);xlim([-2,8]);
subplot(4,1,3);stem(ty,y);title('Convoluzione nel tempo');xlim([-2,8]);
subplot(4,1,3);stem(ty1,y1);title('Convoluzione in frequenza');xlim([-2,8]);
%   Non è venuto lo stesso sengnale ydiversoday1 perchè abbiamo fatto una 
%   convoluzione circolare, la differenza è che all'esterno del segnale x
%   io ipotizzo che il segnale si ripete periodicamente. Il segnale che va
%   da 0 a 4 si ripete da 5 in poi e anche prima di 0. E' una ripetizione
%   periodica del segnale. Andando a fare la convoluzione non verrà lo
%   stesso risultato.
%   Per far si da ottenere lo stesso risultato dobbiamo fare un padding,
%   dobbiamo fare la trasformata di Fourier su più punti, in modo che 
%   continuando a fare la trasformata circolare facendo il prodotto
%   puntuale con Fourier però alcuni dei punti sono pari a 0. Ipotizzando
%   di fare la trasformata su due punti in più è come se il 
%   segnale non va più da 0 a 4 ma da 0 a 6 e 5 e 6 sono posti a 0 cosi non
%   si sovrappongono quando facciamo la replica: Usiamo un numero maggiore
%   di punti, abbiamo bisongo di aggiungere in numero di punti pari al
%   numero di punti di h meno 1. Otteniamo cosi lo stesso risultato.

M=numel(x)+numel(h)-1;
X=fft(x,M);
H=fft(h,M);
Y=X.*H;
y1=real(ifft(Y));
ty1=0:numel(y1)-1;
figure(2);
subplot(4,1,1);stem(tx,x);xlim([-2,8]);
subplot(4,1,2);stem(th,h);xlim([-2,8]);
subplot(4,1,3);stem(ty,y);title('Convoluzione nel tempo');xlim([-2,8]);
subplot(4,1,4);stem(ty1,y1);title('Convoluzione in frequenza');xlim([-2,8]);

%   Usando un numero maggiore di punti ho fatto in modo di fare del padding
%   mettendo dei zeri nel segnale, in modo tale che quando andiamo a fare
%   la convoluzione del segnale non si sovrappongono le repliche, e quindi
%   la convoluzione circolare coincide con la convoluzione classica.
