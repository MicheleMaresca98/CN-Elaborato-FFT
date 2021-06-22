clear all; close all; clc;

x = double(imread("anelli.tif"));
figure;imshow(x,[0 255]);

%   Trasformata bidimensionale
[M,N] = size(x);
P = 3*M;
Q = 3*N;
X=fft2(x,P,Q);

%   Uscir� non centrata e se non passo le dimensioni desiderate la fa di 
%   default su un numero di punti pari alla dimensione dell'immagine.
%   Visualizzare l'immagine con abs uscir� con molti valori bassi(� tutta nera),
%   quindi non noto le frequenze per cui user� log(abs(X)) 
%   per visualizzarla meglio non � neanche centrata,quindi vedr� le basse 
%   frequenze ai bordi

figure; imshow(log(1+abs(X)),[]);title("Trasformata non centrata");
Xf=fftshift(X);
v0 = -0.5:1/P:(0.5-1/P);
v1 = -0.5:1/Q:(0.5-1/Q);
figure; imshow(log(abs(Xf)+1),[], "XData", v1, "YData",v0);title("Trasformata centrata"); axis on;
figure;
[l,k] = meshgrid(v1,v0); %elle, k
mesh(k,l, log(abs(Xf)+1));
