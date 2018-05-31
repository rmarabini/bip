a = [5 7 8; 0 1 9; 4 3 6];
A = fft2(a)
col=sum(a);%sum columns
row=sum(a,2);%sum rows
fft(col)
fft(row)

a2=[1 2; 3 4]
fft2(a2)
