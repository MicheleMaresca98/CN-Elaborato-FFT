% 3. Liveness detection. Esistono diverse tecniche per cercare di scoprire se
% un?impronta digitale `e autentica o contraffatta. Una delle piu` semplici 
% opera nel dominio di Fourier, calcolando la frazione di energia contenuta 
% alle medie frequenze, e dichiarando l?immagine autentica se tale frazione 
% supera una certa soglia.
%      Scrivete una funzione function EM = elabora(x, r1, r2) che calcola la 
%      DFT-2D, X(?,?), di un?immagine x(m, n), valuta l?energia alle medie 
%      frequenze come EM = 1 ? |X (?, ? )|2 dove ? =
% |?| ?
% {(?, ?) : r1 ? ??2 + ?2 ? r2} e |?| `e la cardinalit`a di ?, cioè il 
% numero di punti che soddisfano questa
%  condizione.
% Applicate la funzione alle due immagini impronta1.tif e impronta2.tif, 
% usando raggio interno r1 = 0.10 e raggio esterno r2 = 0.25 ed etichettate 
% come vera quella che fornisce il valore maggiore di EM /E, con E energia 
% dell?immagine.
clear;close all;clc;
x1=double(imread('impronta1.tif'));
x2=double(imread('impronta2.tif'));
r1=0.10;r2=0.25;
y1=elaboradivertente(x1,r1,r2);
y2=elaboradivertente(x2,r1,r2);
% y1=elabora(x1,r1,r2);
% y2=elabora(x2,r1,r2);
[massimo,indice]=max([y1,y2])