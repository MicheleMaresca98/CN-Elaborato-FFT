clear;close all;clc;
x=double(imread('lena.jpg'));
%   Progetto filtro in frequenza
[M,N]=size(x);
X=fftshift(fft2(x));
m=-0.5:1/M:0.5-1/M;
n=-0.5:1/N:0.5-1/N;
figure(1);subplot(1,2,1);imshow(x,[0 255]);title('img');
subplot(1,2,2);imshow(log(1+abs(X)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf img');

[l,k]=meshgrid(n,m);
d=sqrt((l-0).^2+(k-0).^2);
th=0.1;
%   Ricapitolo filtri: 
%   H=d<th;                                                               %     E' un filtro passa basso ideale
%   H=exp(-d.^2/(2*th*th));                                               %     E' un filtro passa basso non ideale
%   H=d>th;                                                               %     Filtro passa alto ideale
                                                                          %     Permette di evidenziare le discontinuità 
                                                                          %     all'interno dell'immagine.
%   H=1.0-exp(-d.^2/(2*th*th));                                           %     Filtro passa alto
                                                                          %     Otteniamo la gaussiana ribaltata
H=(d>0.1) & (d<0.3);                                                      %     Filtro passa banda

h=ifftshift(real(ifft2(ifftshift(H))));
figure(2)
subplot(1,3,1);imshow(log(1+abs(H)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf filtro');
subplot(1,3,2);mesh(l,k,H);
subplot(1,3,3);imshow(h,[]);title('Risposta impulsiva del filtro');

Y=X.*H;
y=real(ifft2(ifftshift(Y)));
figure(3);
subplot(1,2,1);imshow(y,[]);title('img filtrata');
subplot(1,2,2);imshow(log(1+abs(Y)),[],'XDATA',n,'YDATA',m);axis('on');title('tasf img filtrata');
