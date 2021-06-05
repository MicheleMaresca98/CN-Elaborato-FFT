%   Trasformata di Fourier con prodotto matriciale.
clear all;close all;clc;
N=20;
n=[0:N-1];
k=[0:N-1];
x=zeros(N);
L=5;
x(1:L)=1;                                                                 % Impulso rettangolare di durata L
figure;stem(n,x);title('Segnale');
W=zeros(N,N);
                                                                          % Usare j senza definirla vale a dire unità complessa

W=exp(-j*2*pi*k'*n/N);                                                    %   Costruiamo dalla matrice dei vettori w 
                                                                          %   per il cambiamento di base
                                                                          
%x=x.';                                                                   %  necessario se x + un vettore riga
X=W*x;                                                                    % Formula analisi trasformata discreta di fourier su N punti
x=(W'*X)/N;                                                               % Formula sintesi trasformata discreta di fourier su N punti



figure;subplot(2,1,1);stem(n,abs(X));title('Ampiezza trasformata');
subplot(2,1,2);stem(n,angle(X));title('Fase trasformata');

%   Ricordando che la trasformata è periodica tra 0 e 1 definiamo v per 
%   ridefinire l'asse delle frequenze:

v=[0:(1/N):1-1/N];
figure;subplot(2,1,1);stem(v,abs(X));title('Ampiezza trasformata tra 0 e 1');
subplot(2,1,2);stem(v,angle(X));title('Fase trasformata tra 0 e 1');

%   Per ordinare le  frequenze con le basse frequenze al centro:
X=fftshift(X);
figure;subplot(2,1,1);stem(v,abs(X));title('Ampiezza trasformata tra -1/2 e 1/2 con fftshift');
subplot(2,1,2);stem(v,angle(X));title('Fase trasformata tra -1/2 e 1/2 con fftshift');

%   Ridefiniamo le frequenze(analogo di  fftshift):

v2=[-0.5:(1/N):0.5-1/N];    %   vale con N pari
figure;subplot(2,1,1);stem(v2,abs(X));title('Ampiezza trasformata tra -1/2 e 1/2 variando v2');
subplot(2,1,2);stem(v2,angle(X));title('Fase trasformata tra -1/2 e 1/2 variando v2');


N=20;
n=[0:N-1];
k=[0:N-1];
x1=zeros(N);
L=5;
x1(1:L)=1; 


X1=fft(x1,N);                                                                    % Formula analisi trasformata discreta di fourier su N punti
x1=ifft(X1,N);                                                               % Formula sintesi trasformata discreta di fourier su N punti

x=zeros(N);
L=5;
x(1:L)=1;                                                                 % Impulso rettangolare di durata L

trasf_prod=@(x) W*x;

t1=timeit(@() fft(x1))
t2=timeit(@() trasf_prod(x))


figure;subplot(2,1,1);stem(n,abs(X1));title('Ampiezza trasformata');
subplot(2,1,2);stem(n,angle(X1));title('Fase trasformata');

%   Ricordando che la trasformata è periodica tra 0 e 1 definiamo v per 
%   ridefinire l'asse delle frequenze:

v=[0:(1/N):1-1/N];
figure;subplot(2,1,1);stem(v,abs(X1));title('Ampiezza trasformata tra 0 e 1');
subplot(2,1,2);stem(v,angle(X1));title('Fase trasformata tra 0 e 1');

%   Per ordinare le  frequenze con le basse frequenze al centro:
X=fftshift(X1);
figure;subplot(2,1,1);stem(v,abs(X1));title('Ampiezza trasformata tra -1/2 e 1/2 con fftshift');
subplot(2,1,2);stem(v,angle(X1));title('Fase trasformata tra -1/2 e 1/2 con fftshift');

%   Ridefiniamo le frequenze(analogo di  fftshift):

v2=[-0.5:(1/N):0.5-1/N];    %   vale con N pari
figure;subplot(2,1,1);stem(v2,abs(X1));title('Ampiezza trasformata tra -1/2 e 1/2 variando v2');
subplot(2,1,2);stem(v2,angle(X1));title('Fase trasformata tra -1/2 e 1/2 variando v2');



