% 3.Liveness detection.Esistono diverse tecniche per cercare di scoprire se
% un?impronta digitale è autentica o contraffatta. Una delle più semplici 
% opera nel dominio di Fourier, calcolando la frazione di energia contenuta 
% alle medie frequenze, e dichiarando l?immagine autentica se tale frazione 
% supera una certa soglia.
% Scrivete una funzione function EM = elabora(x, r1, r2) che calcola la 
% DFT-2D, X(?,?), di un?immagine x(m, n), valuta l?energia alle medie 
% frequenze come EM = 1 /|?| sum(|X (?, ? )|^2) dove ? =
% {(?, ?) : r1 ? radical(?^2 + ?^2) ? r2} e |?| è la cardinalità di ?, cioè
% il numero di punti che soddisfano questa condizione.
% Applicate la funzione alle due immagini impronta1.tif e impronta2.tif, 
% usando raggio interno r1 = 0.10 e raggio esterno r2 = 0.25 ed etichettate 
% come vera quella che fornisce il valore maggiore di EM/E, con E energia 
% dell?immagine.

function EM = elabora(x, r1, r2)
[M,N]=size(x);
P=M; Q=N;
du=1/P; dv=1/Q;
m=-1/2:du:1/2-du; 
n= -1/2:dv:1/2-dv; 
[l,k] = meshgrid(n,m); 
X=fftshift(fft2(x,P,Q)); 
Z1=log(1+abs(X));
figure; imshow(Z1,[]);

D = sqrt(k.^2+l.^2); 
H1 = (D <= r1);
H2 = (D <= r2); 
H = H2-H1;

Zf = X.*H;
Zfv=log(1+abs(Zf));
figure; imshow(Zfv,[]);
EM = sum(abs(Zf(:)).^2)/(N*M); 
E = sum(abs(X(:)).^2)/(N*M);
EM/E
end

