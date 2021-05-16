function y = gaussLPF(x,sigma)
[M N]=size(x);
P = M; Q = N;
du = 1/M; dv = 1/N;
m = -1/2:du:1/2-du;
n = -1/2:dv:1/2-dv; 
[l,k] = meshgrid(n,m); 
D = sqrt(k.^2+l.^2);
H = exp(-D.^2/(2*sigma^2));                                               %   Filtro gaussiano
X = fftshift(fft2(x));
Y = H.*X;
y=real(ifft2(fftshift(Y),M,N));
