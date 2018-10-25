function f = audpow(y, Fs)

figure
m = length(y);
n = pow2(nextpow2(m));
variabelNamn = fft(y,n);
power = variabelNamn.*conj(variabelNamn)/n;
f = (0:n-1)*(Fs/n);
loglog(f,power);
xlim([1,20000]);
ylabel('Power');
xlabel('Frekvens (Hz)');
title('Effektspektrum av ljudet');

end

