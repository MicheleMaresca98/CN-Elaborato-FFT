clear all; close all; clc;
%   Uso dell'antitrasformata per capire fase e ampiezza della fft.

x = double(imread("volto.tif"));
[M,N] = size(x);
X=fft2(x);
Xf=fftshift(X);
v0 = -0.5:1/M:(0.5-1/M);
v1 = -0.5:1/N:(0.5-1/N);
subplot(1,3,1); imshow(x,[]);title("Immagine"); 
subplot(1,3,3); imshow(angle(Xf),[], "XData", v1, "YData",v0);title("Fase Trasformata"); axis on;
subplot(1,3,2); imshow(log(abs(Xf)+1),[], "XData", v1, "YData",v0);title("Ampiezza Trasformata"); axis on;

%   Metto i real per prendere solo la parte reale della trasformata
X1 = abs(X);                                                              %   Trasformata con solo il modulo
x1 = real(ifft2(X1));                                                     %   Quando ricostruisco devo mettere
                                                                          %   real perchè il segnale è reale 
                                                                          %   ma la trasformta è complessa

%   X2 = exp(j*angle(X)); %per ottenere un versore di modulo 1 e angolo pari
%   alla fase di X oppure X./abs(X) entrambe servono per togliere le ampiezze
X2 = X./abs(X);                                                           %   Trasformata con solo le fasi
x2 = real(ifft2(X2));
subplot(1,3,1); imshow(x,[]);title("Immagine"); 

%   Tolgo il minimo per assicurarmi che siano tutti positivi, in quanto il
%   minimo è negativo e sottraendo ogni volta è come se traslassi la funzione
%   e avrei tutti valori positivi di modo che la potenza 0.3 non renda valori
%   immaginari
subplot(1,3,2); imshow((x1-min(x1(:))).^0.3,[]);title("Immagine ricostruita solo ampiezza"); %Faccio x1.^0.3 per enfatizzare le basse freq 
subplot(1,3,3); imshow(x2,[]);title("Immagine ricostruita solo fase"); 
%   Ricostruendo il segnale non è detto che esce tra 0 e 255 quindi
%   facciamo lo stretch dell'istogramma con []

%   Ora proviamo a combinare modulo di una trasf e angolo di un'altra
y = double(imread("rettangolo.jpg"));
Y = fft2(y);

Y1= abs(X).*exp(j*angle(Y));
Y2= abs(Y).*exp(j*angle(X));
y1 = real(ifft2(Y1));
y2 = real(ifft2(Y2));
figure;
subplot(2,2,1); imshow(x,[]);title("Immagine volto(x)"); 
subplot(2,2,2); imshow(y,[]);title("Immagine rettangolo(y)"); 
subplot(2,2,3); imshow(y1,[]);title("immagine ricostruita fase y amp x"); % L'immagine sarà più simile a y
subplot(2,2,4); imshow(y2,[]);title("immagine ricostruita fase x amp y"); % L'immagine è più simile a x
