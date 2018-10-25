clear
close all
clc 

frequency = 300;
Fs = 44100;
soundlength = 3;
t = [0:1/Fs:1/Fs*511];
width = 0.3;
width2 = 49;
osc1 = sawtooth(2*pi*frequency*t, width);
osc2 = sawtooth(2*pi*(frequency + 1)*t, width);
osc3 = square(2*pi*(frequency / 2)*t, width2);
osc4 = sin(2*pi*(frequency*2)*t);
mix = osc1*0.5 + osc2 + osc3*0.75 + osc4;
miniMoogLjud = mix ./ max(abs(mix));

miniMoogLjud2 = [miniMoogLjud];

plot(miniMoogLjud2)