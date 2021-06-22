%   Filtraggio immagine a colori
%   Il filtraggio pu� essere fatto o sulle tre componenti o solo
%   sull'intensit� luminosa
clear;close all;clc;
x=imread('foto_originale.tif');
x=double(x)/255;
R=x(:,:,1);
G=x(:,:,2);
B=x(:,:,3);
figure(1);imshow(x);title('Immagine a colori');
h=fspecial('average',15);
R=imfilter(R,h);
G=imfilter(G,h);
B=imfilter(B,h);
y=cat(3,R,G,B);
%   fspecial3 serve per immagini 3D come risonanze magnetiche e non per
%   immagini a colori.
%   Per le immagini a colori le tre operazioni di separazione delle
%   componenti e il filtraggio delle singole componenti una per volta �
%   evitabile andando a usare imfilter direttamente sull'immagine, perch�
%   imfilter capisce direttamente che x � un'immagine a colori e che deve
%   filtrare ogni componente.
%   Avremmo potuto usare y=imfilter(x,h);

%   Filtrando tutte e tre le componenti abbiamo sia sfocato l'intensit�
%   luminosa che la tinta dove stanno i bordi, proviamo allora a fare la
%   stessa cosa solo sull'intensit� luminosa

figure(2);
imshow(y);title('img. filtraggio in RGB');
%   Ci serve uno spazio che separi l'intensit� luminosa, possiamo usare hsi
%   hsv ma anche cbcr
w=rgb2ycbcr(x);
I=w(:,:,1);
Cb=w(:,:,2);
Cr=w(:,:,3);
%   Applichiamo il filtraggio solo alla componente di intensit�
I=imfilter(I,h);
w=cat(3,I,Cb,Cr);
y2=ycbcr2rgb(w);
figure(3);
imshow(y2);
title('img. filtraggio solo di I');
%   L'effetto di smoothing non � andato ad incidere sulle discontinuit�
%   legate alla tinta se facciamo lo zoom sulle labbra, vediamo lo stacco 
%   netto dal rosso al rosa in cbcr mentre non c'� lo stacco in RGB