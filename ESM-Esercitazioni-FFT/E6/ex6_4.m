clear;close all;clc;
x=double(imread('lena.jpg'));
%   Progetto filtro in frequenza
[M N]=size(x);
X=fftshift(fft2(x));
m=-0.5:1/M:0.5-1/M;
n=-0.5:1/N:0.5-1/N;
figure(1);subplot(1,2,1);imshow(x,[0 255]);title('img');
subplot(1,2,2);imshow(log(1+abs(X)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf img');

%   La trasformata dell'immagine ha zero alle alte frequenze, ha uno alle
%   basse frequenze però solo in un cerchio intorno all'origine, possiamo
%   pensare di progettare un filtro che fa passare solo le alte frequenze
%   con un quadrato che cancella le basse.
%   Per progettare un filtro circolare ci servirebbe la distanza di ogni
%   coordinata con il centro e poi fare una sogliatura.
   
[l,k]=meshgrid(n,m);
d=sqrt((l-0).^2+(k-0).^2);                                                %    Distanza con il centro del generico punto l,k.
th=0.1;
H=d<th;                                                                   %    Filtro passa basso a forma circolare
h=fftshift(real(ifft2(ifftshift(H))));
figure(2)
subplot(1,3,1);imshow(log(1+abs(H)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf filtro');
subplot(1,3,2);mesh(l,k,H);
subplot(1,3,3);imshow(h,[]);title('Risposta impulsiva del filtro');

Y=X.*H;
y=real(ifft2(ifftshift(Y)));
figure(3);
subplot(1,2,1);imshow(y,[0 255]);title('img filtrata');
subplot(1,2,2);imshow(log(1+abs(Y)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf img filtrata');

%   L'effetto di ringing che si ha su Lena è dovuto al fatto che abbiamo
%   utilizzato un filtro ideale che è un salto netto, come una rect, tra 0
%   e 1 e di conseguenza la trasformata sarà una sinc. Se volessimo
%   togliere questo effetto dobbiamo utilizzare un filtro gaussiano quindi
%   al posto di mettere una soglia netta H=d<th; possiamo mettere la
%   formula della gaussian H=exp(-d.^2/(2*th*th));
%   Con il sigma della gaussiana decidiamo quante frequenze far passare.
