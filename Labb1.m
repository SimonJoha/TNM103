close all 
clear
volume = 0.75;
frequency = 300;
Fs = 44100;
soundlength = 3;
t = [0:1/Fs:soundlength];
width = 0.3;
osc1 = sawtooth(2*pi*frequency*t, width);
osc2 = sawtooth(2*pi*(frequency + 1)*t, width);
osc3 = sawtooth(2*pi*(frequency / 2)*t, width);
miniMoogLjud3 = (osc1+osc2+(osc3*volume))/3;


% osc1 = sawtooth(2*pi*freq*t, width);
% osc2 = sawtooth(2*pi*(freq-3)*t, 0.3);
% osc3 = sawtooth(2*pi*(freq/2)*t, width);

Fc = 2200;
n = 4; 
Wn = (Fc/(Fs/2));

[b,a] = butter(n,Wn);

y = filter(b,a,miniMoogLjud3);

freqz(b, a);
window = 512;
noverlap = 256;
nfft = 512;
figure();
spectrogram(t, window, noverlap, nfft, Fs, 'yaxis');
ylim([0,2]);
title('Spektrogram av ljudet');
xlabel('Tid (s)');
ylabel('Frekvens (kHz)');

attack = 1; 
decay = 1;
sustain = 0.8;
release = 0.5; %22050 sampels

A = linspace(0,1,(0.2*Fs*3));
D = linspace(attack,sustain,(0.3*Fs*3));
S = ones(1, Fs*0.4*3+1)*sustain;
R = linspace(0.8,0,(3*Fs*0.1));

adsr = [A D S R];

plot(adsr)
y2 = y .* adsr;


p = audioplayer(y2, Fs);
playblocking(p);
% 
figure();
plot(y);