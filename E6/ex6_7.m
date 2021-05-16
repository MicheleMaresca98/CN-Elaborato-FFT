%   Esercizio 2 PROVA D'ESAME
% 2. Pattern di Moirè. L'immagine car.tif è caratterizzata dal pattern 
% di moirè, un artefatto piuttosto fastidioso che può essere generato da 
% una scansione non appropriata di una fotografia stampata su di un giornale.
% Dopo aver osservato attentamente la trasformata di Fourier dell'immagine, 
% scrivete il codice matlab in cui rimuovete questo disturbo attraverso un 
% opportuno filtro ideale e mostrate l'immagine risultante.

clear;close all;clc;
x=double(imread('car.tif'));
[M N]=size(x);
X=fftshift(fft2(x,M,N));
du=1/M;
dv=1/N;
m=-0.5:du:0.5-du;
n=-0.5:dv:0.5-dv;
[l,k]=meshgrid(n,m);
figure(1);
subplot(1,3,1);imshow(x,[]);title('Immagine rumorosa');
subplot(1,3,2);imshow(log(1+abs(X)),[],'XDATA',n,'YDATA',m);axis('on');title('Trasformata Fourier immagine rumorosa');
subplot(1,3,3);mesh(k,l,log(1+abs(X)));

%   La componente principale dell'immagine è alle basse frequenze e abbiamo
%   una riga dovuta ai bordi, inoltre abbiamo dei picchi(4) dovuti a
%   pattern, sono dei picchi precisi ad una frequenza obliqua, quindi sia
%   orizzontale che verticale, cioè la griglia. Per eliminarli bisogna 
%   eliminare la griglia bisonga eliominare i 4 picchi. Inoltre abbiamo che
%   questi hanno anche delle frequenze secondarie.

%   Vediamo dal grafico in figura 1 con DATA TIPS che le frequenze sono
%   0.17 -15 e -0.17 0.15, ecc..., tutte le 4 combinazioni.
%   Il centro delle frequenze è 0.17 in orizzontale e 0.16 in verticale,
%   quindi per fare 4 cerchi dobbiamo calcolare 4 distanze
cx=0.17;cy=0.16;
d1=sqrt((l-cx).^2+(k-cy).^2);
d2=sqrt((l+cx).^2+(k+cy).^2);
d3=sqrt((l+cx).^2+(k-cy).^2);
d4=sqrt((l-cx).^2+(k+cy).^2);
%   Definiamo una frequenza di taglio:
B=0.05;
H1=(d1>B)&(d2>B)&(d3>B)&(d4>B);

cx2=0.17; cy2=0.32;
d5=sqrt((l-cx2).^2+(k-cy2).^2);
d6=sqrt((l-cx2).^2+(k+cy2).^2);
d7=sqrt((l+cx2).^2+(k+cy2).^2);
d8=sqrt((l+cx2).^2+(k-cy2).^2);
H2=(d5>B)&(d6>B)&(d7>B)&(d8>B);
H=H1.*H2;


% % Definizione dei filtri
% B = 0.023;
% mu_1 = 0.15; nu_1 = 0.18;
% mu_2 = 0.17; nu_2 = 0.16;
% D = sqrt((k-mu_1).^2+(l-nu_1).^2); H1 = (D <= B);
% D = sqrt((k-mu_2).^2+(l+nu_2).^2); H2 = (D <= B);
% D = sqrt((k+mu_1).^2+(l+nu_1).^2); H3 = (D <= B);
% D = sqrt((k+mu_2).^2+(l-nu_2).^2); H4 = (D <= B);
% B = 0.015;
% mu_1 = 0.32; mu_2 = 0.34;
% D = sqrt((k-mu_1).^2+(l-nu_1).^2); H5 = (D <= B);
% D = sqrt((k-mu_2).^2+(l+nu_2).^2); H6 = (D <= B);
% D = sqrt((k+mu_1).^2+(l+nu_1).^2); H7 = (D <= B);
% D = sqrt((k+mu_2).^2+(l-nu_2).^2); H8 = (D <= B);
% H = 1-H1-H2-H3-H4-H5-H6-H7-H8;
figure(2);
subplot(1,2,1);imshow(log(1+abs(H)),[],'XDATA',n,'YDATA',m);axis('on');title('Trasformata Fourier filtro');
subplot(1,2,2);mesh(k,l,abs(H));

Y = X.*H;
figure; imshow(log(1+abs(Y)),[]); title('Trasformata di Fourier immagine filtrata');
y = real(ifft2(fftshift(Y)));
figure; subplot(1,2,2); imshow(y,[min(y(:)) max(y(:))]);
title('Immagine filtrata');
subplot(1,2,1); imshow(x,[min(y(:)) max(y(:))]); 
title('immagine originale');

