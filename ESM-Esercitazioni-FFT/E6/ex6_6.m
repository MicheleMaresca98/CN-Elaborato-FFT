clear;close all;clc;

%   Progettare un filtro per eliminiare un pattern che ci serve
%   2.1 Filtraggio di rumore periodico

fp = fopen('lenarumorosa.y','rb');
x = fread(fp, [512 512], 'int16');
x = x';
fclose(fp);
fp = fopen('lena.y','rb');
xo = fread(fp, [512 512], 'uchar');
xo = xo';
fclose(fp);
mse_x=mean2((x-xo).^2);

figure(1);
subplot(1,2,1);imshow(xo,[]);title('Immagine originale');
subplot(1,2,2);imshow(x,[]);title(sprintf('Immagine rumorosa MSE=%f',mse_x));

%   L'immagine è caratterizzata da un rumore additivo ed è periodico perchè
%   è caratterizzato da strisce che si ripetono in verticale e questo rumore
%   ha quindi delle discontinuità orizzontali. Questi rumori periodici sono
%   caratterizzati dal fatto di essere ben localizzati in frequenza.

[M,N] = size(x);
[n,m] = meshgrid(1:N,1:M);
du = 1/M; dv = 1/N;
m = -1/2:du:1/2-du; 
n = -1/2:dv:1/2-dv;
[l,k] = meshgrid(n,m);                                                    % Contiene le coordinate orizzontali e verticali
X = fftshift(fft2(x));

figure(2);
subplot(1,2,1);imshow(log(1+abs(X)),[],'XDATA',n,'YDATA',m);axis('on');title('Trasformata di Fourier immagine rumorosa');
subplot(1,2,2); mesh(l,k,log(1+abs(X)),'XDATA',n,'YDATA',m);axis('on');title('Trasformata di Fourier immagine rumorosa');

%   Osservando la trasformata si vede il classico picco centrale dovuto
%   alla componente continua, la montagnetta intorno al picco centrale è il
%   contenuto classico delle immagini naturali però si vedono altri due
%   picchi, in posizione 0.2 0 e -0.2 0. Questi due picchi sono simmetrici
%   e corrispondono ad una sinusoide. Due impulsi simmetrici in frequenza
%   sono una sinusoide nello spazio e questo pattern che abbiamo è molto
%   simile ad una isnusoide, esso è infatti una sinusoide che varia
%   orizzontalemente e quindi si trovano che i due picchi stanno sull'asse
%   orizzonatale. Se eliminiamo i due picchi e lasciamo la componente
%   continua e tutto il suo intorno possiamo far si da lasciare il
%   contenuto dell'immagine ma andiamo a cancellare solo il rumore. I due
%   picchi presentano anche dei lobi secondari a destra e a sinistra perchè
%   il rumore non è perfettamente una sinusoide quindi ci sono oltre alla
%   frequenza principale del pattern anche delle frequenze secondarie,
%   questo perchè la sinusoide è limitata nello spazio. Questa limitazione
%   nello spazio indica che il segnale non deve essere limitato in
%   frequenza e quindi deve per forza avere tutte le frequenze secondarie.

%   Definizione del filtro
%   B è una banda di taglio 
nu_0 = 0.2; B = 0.03;
D = sqrt(k.^2+(l-nu_0).^2);

%   l sono le frequenze orizzontali dato che il picco si trova in posizione 
%   [X Y][0.2 0] scriviamo allora l-0.2 e k-0.

H1 = (D <= B);                                                            %   Distanza rispetto al primo picco
D = sqrt(k.^2+(l+nu_0).^2);
H2 = (D <= B);

%   Distanza rispetto al secondo picco, per simmetria sta a [X Y][-0.2 0.0]
%   lo si può vedere direttamente dal grafico nel quale abbiamo messo gli
%   assi in figura 2 premendo sulla icona del commento (DATA TIPS).

H = 1-H1-H2;
figure(3); 
subplot(1,2,1);imshow(H,'XDATA',n,'YDATA',m);axis('on'); title('Riposta in frequenza del filtro');
subplot(1,2,2);mesh(l,k,H);
% Filtraggio
Y = X.*H;

figure(4);
subplot(1,3,1);mesh(l,k,log(1+abs(Y)));
y = real(ifft2(fftshift(Y)));
%   Valutiamo anche l'effetto del filtraggio fatto fino ad ora:
%   Calcolo MSE
mse_y = mean2((y-xo).^2);
figure(4);
subplot(1,3,2);imshow(y,[]); title(sprintf('Immagine filtrata MSE=%f',mse_y));
subplot(1,3,3);imshow(log(abs(Y)+1),[],'XDATA',n,'YDATA',m);axis('on'); title('Trasformata di Fourier immagine filtrata'); 

%   Lena non risulta distorta perchè le basse frequenze le abbiamo
%   preservate e abbiamo cancellato solo i picchi.
%   Il resto della distorsione è dovuto alla coda dei picchi, dalle
%   frequenze secondarie quindi dovremmo cancellare anche queste.
%   Proviamo ora a progettare un filtro che elimina anche le frequenze
%   secondarie del rumore, definiamo in frequenza due rettangoli.
%   Vedendo l'immagine 4 si nota che dobbiamo levare il rettangolo
%   orizzontale che va da -0.5 a -0.16 e quello che va da 0.16 a 0.5
%   L'altezza del rettangolino sempre vedendo la figura 4 con DATA TIPS
%   risulta circa alta da -0.2 a 0.2

% Definizione del filtro
 B = 0.03;

H1=(l<-0.16)&(k>-B)&(k<B);
H2=(l>0.16)&(k>-B)&(k<B);
H=1.0-H1-H2;

figure(5); 
subplot(1,3,1);imshow(H1,[],'XDATA',n,'YDATA',m);axis('on');
subplot(1,3,2);imshow(H2,[],'XDATA',n,'YDATA',m);axis('on');
subplot(1,3,3);imshow(H,[],'XDATA',n,'YDATA',m);axis('on');

Y = X.*H;
y = real(ifft2(fftshift(Y)));
MSE2 = mean2((y-xo).^2);
figure; imshow(y,[],'XDATA',n,'YDATA',m);axis('on'); title(sprintf('Immagine filtrata2 MSE=%f',MSE2)); 
%   Il MSE risulta ulteriormente ridotto.
%   Avremmo anche potuto definire un filtro quadrato centrale come ho fatto
%   nell'altro script _prova.

