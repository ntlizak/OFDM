function [ I, Q, kwadr, r1, trans, wyjscie] = MPSK( s, p )

sym=3/(2^(1/2));
MPSKmap= [-sym-sym*1j,-3,3j,-sym+sym*1j,-3j,sym-sym*1j,sym+sym*1j, 3];

k=0;
l=1;

dlugosc = length(s);
uzupelnienie=0;

if (mod(dlugosc, 6) ~= 0)
    uzupelnienie = 6 - mod(dlugosc,6);
    temp=s;
    s = zeros(1, dlugosc + uzupelnienie);
    s(1:dlugosc) = temp(1:end);
end;

temp=0;

%%% rozdzielam wektor na podnosne

for i=1:(length(s))
    if mod(i,3)==1
        l=1;
        k=k+1;
    end
    
    podn(k,l)=s(i);
    l=l+1;
end

%%% Q i I

rozmiar=size(podn);

for i=1:rozmiar(1)
    for k=1:rozmiar(2)
        indeks(k)=podn(i,k);
    end
    
    indeks=sum(indeks.*[4 2 1]);
   
    symbol = MPSKmap(indeks+1); 
   
    I(i)=real(symbol);
    Q(i)=imag(symbol);
    
end

%%% przygotowuje do transformaty

for i=1:rozmiar(1)
    rownania(i)= I(i) + Q(i)*1j;
end

rownania=[rownania(1:end/2) zeros(size(rownania)) rownania(end/2+1:end)];


%%% odwrotna transformata

odwr_trans=ifft(rownania);

%%% modulacja kwadraturowa

rz2 = real(odwr_trans);
im2 = imag(odwr_trans);

t=1:length(rz2);
sn = exp(1j*t*pi/2);

%kwadr = rz2 .* real(sn) - im2 .* imag(sn);     %powinno byc zespolone, ale
                                                %duza ilosc bledow
                                                
kwadr = (rz2 + im2 * 1j).*sn;

% ewentualnie zaszumiam
moc_sygnalu = sum(abs(kwadr).^2)/length(kwadr);
moc_szumu =moc_sygnalu*(10^(-p/10));
szum = sqrt(moc_szumu)*randn(1,length(kwadr));
kwadr=kwadr+szum;
%%%%%%%%%%%%%%%%%%%%%TU KONCZY SIE MODULACJA%%%%%%%%%%%%%%%%%%%%%%%

%[B, A] = butter(1,0.99);
%kwadr = filter(B,A,kwadr);

%len_f = 128;

%B = fir1(len_f, 0.99, 'low');
%kwadr= filter(B, 1, kwadr);

%%% modulacja kwadraturowa

r1=kwadr.*conj(sn);

%%% transformata fouriera

trans=fft(r1);
trans = [trans(1:end/4) trans(3*end/4+1:end)];
rozmiar = length(trans);

%%% detekcja symboli

I1=real(trans);
Q1=imag(trans);
for i=1:rozmiar
    [a,b] = min(abs((I1(i)+Q1(i)*1j)-MPSKmap));
    temp(3)=mod((b-1),2);
    b=floor((b-1)/2);
    temp(2)=mod(b,2);
    b=floor(b/2);
    temp(1)=b;
    
    wyjscie( (i-1)*3+1 : i*3)=temp;
end

    wyjscie=wyjscie(1:(end-uzupelnienie));
end





