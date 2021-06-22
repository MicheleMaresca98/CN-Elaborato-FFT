%   Trasformata di Fourier con prodotto matriciale e con fft calcolo tempi.
clear all;close all;clc;
N=10000;
n=[0:N-1];
k=[0:N-1];
x=zeros(N);
L=5;
x(1:L)=1;                                                                 
W=zeros(N,N);
                                                                          
W=exp(-1i*2*pi*k'*n/N);                                                  
                                                                          
                                                                          
X=W*x;                                              
X1=fft(x);                                                                                                                                % Impulso rettangolare di durata L

trasf_prod=@(x) W*x;

t1=timeit(@() fft(x))
t2=timeit(@() trasf_prod(x))

% In secondi
% t1 =
% 
%     0.7600
% 
% 
% t2 =
% 
%    41.4683
