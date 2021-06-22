%   Trasformata di Fourier con prodotto matriciale e con fft calcolo tempi.
clear;close all;clc;
N=[10, 50, 100, 200, 300, 400, 500, 600, 700, 800,900, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]';    
format long
trasf_prod=@(x,W) W*x;
t1=zeros(1,length(N));
t2=zeros(1,length(N));
for i=1:length(N)
       disp(N(i))
    n=[0:N(i)-1];
    k=[0:N(i)-1];
    x=zeros(N(i));
    L=5;
    x(1:L)=1;                                                                 
    W=zeros(N(i),N(i));
    W=exp(-1i*2*pi*k'*n/N(i));                                                  
    X=W*x;                                              
    X1=fft(x);                                                                                                                                % Impulso rettangolare di durata L
    t1(i)=timeit(@() fft(x));
    t2(i)=timeit(@() trasf_prod(x,W));
end

figure;plot(t1,N);title('FFT');
figure;plot(t2,N);title('FT');

% In secondi (Per N = 10000)
% t1 =
% 
%     0.7600
% 
% 
% t2 =
% 
%    41.4683
