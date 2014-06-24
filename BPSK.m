function [ I, Q, kwadr, r1, trans, wyjscie] = BPSK( s ,p )

BPSKmap= [-1, 1];
dlugosc = length(s);
uzupelnienie=0;

if (mod(dlugosc, 2) ~= 0)
    uzupelnienie = 2 - mod(dlugosc,2);
    temp=s;
    s = zeros(1, dlugosc + uzupelnienie);
    s(1:dlugosc) = temp(1:end);
end;

temp=0;

rozmiar=length(s);

%%% Q i I
for i=1:rozmiar
    temp = s(i);
    symbol = BPSKmap(temp+1); 
   
    I(i)=real(symbol);
    Q(i)=imag(symbol);
    
end

%%% przygotowuje do transformaty

for i=1:rozmiar
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
    [a,b] = min(abs((I1(i)+Q1(i)*1j)-BPSKmap));
    %temp(4)=mod(b-1,2);
    %b=floor((b-1)/2);
    %temp(3)=mod(b,2);
    %b=floor(b/2);
    %temp(2)=mod(b,2);
    %b=floor(b/2);
    temp=b;    
    wyjscie(i)=temp-1;
end

wyjscie=wyjscie(1:end-uzupelnienie);
end