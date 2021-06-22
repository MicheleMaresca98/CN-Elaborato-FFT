% Filtraggio notch. L?immagine anelli.tif mostra una parte degli anelli che
% circondano Saturno. Il rumore sinusoidale `e dovuto ad un segnale AC 
% sovrapposto a quello della fotocamera prima di digitalizzare l?immagine. 
% Tale interferenza `e semplice da rimuovere se si progetta un filtro notch 
% in grado di cancellare il contributo del rumore. Calcolate quindi la 
% trasformata di Fourier dell?immagine, analizzatela, individuate il 
% contributo realtivo al segnale sinusoidale e cercate di eliminarlo con il 
% filtraggio.
clear;close all;clc;
x=double(imread('anelli.tif'));
X=fftshift(fft2(x));
[M,N]=size(x);
du=1/M;
dv=1/N;
m=-0.5:du:0.5-du;
n=-0.5:dv:0.5-dv;
[l,k]=meshgrid(n,m);
figure(1);
subplot(1,3,1);imshow(x,[0 255]);
subplot(1,3,2);imshow(log(1+abs(X)),[],'XDATA',n,'YDATA',m);axis('on');
subplot(1,3,3);mesh(k,l,log(1+abs(X)));

B=0.04599;
H1=(k<-B)&(l>-0.01)&(l<0.01);
H2=(k>B)&(l>-0.01)&(l<0.01);
H=1.0-H1-H2;

figure(2);imshow(H,[]);
Y=X.*H;
y=real(ifft2(fftshift(Y)));
figure(3);
subplot(1,3,1);imshow(log(1+abs(Y)),[],'XDATA',n,'YDATA',m);axis('on');title('Trasformata immagine filtrata');
subplot(1,3,2);mesh(k,l,log(1+abs(Y)));
subplot(1,3,3);imshow(y,[]); 
