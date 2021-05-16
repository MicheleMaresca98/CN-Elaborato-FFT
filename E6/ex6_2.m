clear;close all;clc;
x=double(imread('lena.jpg'));
h=fspecial('average',7);

h_rip=fliplr(flipud(h));
y1=imfilter(x,h_rip,'full');                                              %   Filtraggio nello spazio

[M,N]=size(x);
[A,B]=size(h);

P=M+A-1;Q=N+B-1;                                                          %   Minimo di punti per ottenere una convoluzione lineare.
                                                                          %   Se prendiamo la dimensione dell'immagine al posto di P e Q
                                                                          %   facciamo la convoluzione circolare e abbiamo che le due 
                                                                          %   immagini differiscono ai bordi perch� in una abbiamo fatto
                                                                          %   la convoluzione lineare e nell'altra abbiamo fatto la 
                                                                          %   convoluzione circolare, in una abbiamo ipotizzato che 
                                                                          %   all'esterno di Lena ci sia lo 0, e nell'altra abbiamo
                                                                          %   ipotizzato che all'esterno di lena ci si una sua replicazione 
                                                                          %   periodica, quindi l'unica parte in cui differiscono � ai bordi
                                                                          %   dove il filtro va a combinare anche i pixel all'esterno 
                                                                          %   dell'immagine e in un caso combina con valori nulli e 
                                                                          %   nell'altro va a combinare con Lena periodica. Eccetto per
                                                                          %   una differenza ai bordi i due risultati sono identici. 
                                                                          %   La dimensione del bordo � legata alla dimensione del 
                                                                          %   filtro, pi� � grande il filtro pi� il bordo differisce.
                                                                          
X=fft2(x,P,Q);
H=fft2(h,P,Q);
Y=X.*H;
y2=real(ifft2(Y));
figure(1);
subplot(1,3,1);imshow(x,[0,255]);title('Immagine originale');
subplot(1,3,2);imshow(y1,[0,255]);title('Convoluzione nello spazio');       
subplot(1,3,3);imshow(y2,[0,255]);title('Convoluzione in frequenza');

%   y1 � 512x512 mentre y2 � 518x518, y2 � la dimensione corretta della
%   convoluzione dei segnali, mentre y1 � imfilter che ritaglia l'immagine
%   per avere una dimensione pari alla dimensione di x. Si pu� chiedere di
%   evitare di fare questo e non ritagliarla dando il parametro 'full' e la
%   dimensione sar� la somma delle due dimensioni meno uno.

Hf=fftshift(H);
Xf=fftshift(X);
Yf=fftshift(Y);
n=-1/2:1/Q:1/2-1/Q;
m=-1/2:1/P:1/2-1/P;

figure(2);
%subplot(1,2,1);imshow(h,[]);title('Risposta impulsiva');
subplot(1,3,1);imshow(log(abs(Xf)+1),[],'XDATA',n,'YDATA',m);axis('on');title('Trasf img originale');
subplot(1,3,2);imshow(abs(Hf),[],'XDATA',n,'YDATA',m);axis('on');title('Trasf H');
%   La risposta in frequenza � concentrata alle basse frequenze.

subplot(1,3,3);imshow(log(abs(Yf)+1),[],'XDATA',n,'YDATA',m);axis('on');title('Trasf Y');

%   Nelle zone in cui la Trasf H � bassa, � pari a 0, come negli spigoli,
%   le frequenze non passano, quindi vado a nullare le frequenze dove la
%   risposta in frequenza � pari a zero mentre al centro, dove la risposta 
%   in frequenza � pari a 1 le frequenze passano inalterate o quasi poich� 
%   il valore del filtro � prossimo a 1. Questo filtro attenua le alte
%   frequenze e fa passare le basse frequenze, � un filtro passa basso.
%   Se aumentiamo la dimensione del filtro da 7 a 19, quindi andiamo ad
%   aumentare la dimensione del filtro:
%   h=fspecial('average',19);
%   Vediamo che l'azione delle frequenze che passano si riduce e abbiamo
%   una maggiore sfocatura dei bordi, rigettiamo maggiore quantit� di
%   frequenze, con una frequenza di taglio pi� piccola perch� ci siamo
%   concentrati pi� al centro facendo passare la componente continua e le
%   basse frequenze vicine alla componente continua e questo da un effetto
%   di sfocatura nello spazio.
%   Consideriamo altri tipi di filtri come quello laplaciano, esso ha 
%   valori zero al centro e valori prossimi a uno negli spigoli, alte 
%   frequenze, questo � un filtro passa alto, fa vedere solo le 
%   discontinuit� nell'immagine, evidenzia i bordi dell'immagine.

%   Il filtro gaussiano invece � una gaussiana in cui dai il sigma che � il
%   terzo parametro mentre il secodno parametro � il supporto del filtro
%   h=fspecial('gaussian',15,0.5); %    E' importante che 15 deve essere
%   almeno 6 volte 0.5 altrimenti esce una gaussiana troncata, la
%   trasformata di una gaussian  � ancora una gaussian e i sigma sono uno
%   il reciproco dell'altro. Se raddoppio il sigma nello spazio dimezza in
%   frequenza. Se aumento il sigma della gaussiana riduco le frequenze che
%   passano. Pi� grande � il sigma della gaussiana nello spazio pi� riduco
%   le frequenze che passano e pi� ottengo un'immagine sfocata. Facendo
%   1-PASSA_BASSO ottengo un filtro passa alto. 

