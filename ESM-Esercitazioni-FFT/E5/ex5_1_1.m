clear all;close all;clc;
N=10;
W=zeros(10,10);
for n=0:N-1
    for k=0:N-1
        W(k+1,n+1)=exp(-j*2*pi*n*k/N);                                    % Rappresenta la base della trasformazione di Fourier discreta
    end
end
figure(1);
%imshow(real(W),[]);
for i=1:5
    subplot(3,2,i);
    plot(real(W(i,:)));
end

L=8;
t=0:N-1;
x=zeros(N);x(1:L)=1;
y=(-1).^t;
x=y;x(L+1:end)=0;
%X=W*x
X=fft(x,N);
%xr=ifft(X);%per l'anti-trasformata
v=0:1/N:(1-1/N);
% figure(2);
% subplot(1,3,1);stem(t,x);title('Segnale');
% subplot(1,3,2);stem(v,abs(X));title('Ampiezza della trasformata');
% subplot(1,3,3);stem(v,angle(X));title('Fase della trasformata');
Xf=fftshift(X);
v=-0.5:1/N:(0.5-1/N);
figure(2);
subplot(1,3,1);stem(t,x);title('Segnale');
subplot(1,3,2);stem(v,abs(Xf));title('Ampiezza della trasformata');
subplot(1,3,3);stem(v,angle(Xf));title('Fase della trasformata');

%   Aumentando N aumento il numero di punti che considero per la
%   trasformata discreta di fourier è si vede meglio.

%   Se aumento la durata diminuisce la banda in frequenza
%   Se L=N ottengo l'impulso