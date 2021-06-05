%   Trasformata di Fourier con prodotto matriciale e con fft calcolo tempi.
clear;close all;clc;
N=10000;    
trasf_prod=@(x,W) W*x;
t1=zeros(4,1);
t2=zeros(4,1);
for i=1:4
       disp(N)
    n=[0:N-1];
    k=[0:N-1];
    x=zeros(N);
    L=5;
    x(1:L)=1;                                                                 
    W=zeros(N,N);
    W=exp(-1i*2*pi*k'*n/N);                                                  
    X=W*x;                                              
    X1=fft(x);                                                                                                                                % Impulso rettangolare di durata L
    t1(i)=timeit(@() fft(x))
    t2(i)=timeit(@() trasf_prod(x,W))
    N=N/10;
end

figure;plot(t1,1:4)title('FFT')
figure;plot(t2,1:4)title('FT')

% In secondi (Per N = 10000)
% t1 =
% 
%     0.7600
% 
% 
% t2 =
% 
%    41.4683
