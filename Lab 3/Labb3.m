clear
clc
close all

Fs = 44100;
slength = 3;
p = -14; % -6 = 0.25 watts
frequency = 130;
t = [0: 1 / Fs :slength];
f0 = sin(2*pi*frequency.*t);

[m,n] = size(t);

% y2 = awgn(osc1, 10);
% y2 = y2 / max(abs(y2));

% noise = wgn(1,(Fs*3 + 1), 0);
noise = wgn(m,n,p);
noise = noise / (max(abs(noise)));

freq1 = 660;
f1Under = freq1 - freq1 * 0.1;
f1Over = freq1 + freq1 * 0.1;

freq2 = 1720;
f2Under = freq2 - freq2 * 0.07;
f2Over = freq2 + freq2 * 0.07;

freq3 = 2410;
f3Under = freq3 - freq3 * 0.05;
f3Over = freq3 + freq3 * 0.05;

fc = 300;
% Wn1 = fc/Fs;
Wn1 = ([f1Under, f1Over]/(Fs/2)); 
Wn2 = ([f2Under, f2Over]/(Fs/2)); 
Wn3 = ([f3Under, f3Over]/(Fs/2)); 

[b1,a1] = butter(2, Wn1, 'bandpass');
dataOut1 = filter(b1, a1, noise);
mag1 = db2mag(-1) * dataOut1;
[b2, a2] = butter(2, Wn2, 'bandpass');
dataOut2 = filter(b2, a2, noise);
mag2 = db2mag(-12) * dataOut2;
[b3, a3] = butter(2, Wn3, 'bandpass');
dataOut3 = filter(b3, a3, noise);
mag3 = db2mag(-22) * dataOut3;


output = (f0 + mag1 + mag2 + mag3);
output = output / (max(abs(output)));
infadeVector = [0:5/Fs:1];
outfadeVector = fliplr(infadeVector);

langd = 2*length(infadeVector);

oneVector = ones(1, length(f0)-langd);

fadeVector = [infadeVector, oneVector, outfadeVector];

output = output.*fadeVector;

% dataOut = (f0 * 0.8 +  dataOut1 * 0.4 + dataOut2 * 0.2 + dataOut3 * 0.4);
% fadeVektor = [0:1/4410:1];
% fadeOut = fliplr(fadeVektor);
% [thingy,fadeSize] = size(fadeVektor);
% 
% oneVector = ones(m, n - 2*fadeSize);
% weirdVec = [fadeVektor oneVector fadeOut];
% 
% dataOut = mag1 + mag2 + mag3;
% dataOut = dataOut / max(abs(dataOut));
% 
% dataOut = dataOut .* weirdVec;

p = audioplayer(output, Fs);
playblocking(p);


%%

outputSine = sin(2*pi*t.*f0+(3*sin(2*pi*t.*f0*0.7+(3*sin(2*pi*t.*f0*0.5+(3*sin(2*pi*t.*f0*0.3)))))));

[b,a] = butter(2, Wn1, 'bandpass');

f1 = filter(b,a,outputSine);

[b2,a2] = butter(2, Wn2, 'bandpass');

f2 = filter(b2,a2,outputSine);

[b3,a3] = butter(2, Wn3, 'bandpass');

f3 = filter(b3,a3,outputSine);


f1mag =  db2mag(-1);
f2mag =  db2mag(-12);
f3mag =  db2mag(-22);

f1 = f1.*f1mag;
f2 = f2.*f2mag;
f3 = f3.*f3mag;

ljud = (f0+f1+f2+f3);
 
ljud = ljud/(max(abs(ljud)));


% ljud = ljud.*fadeVector;

p = audioplayer(ljud, Fs);
playblocking(p);


%% SINUS SUMMERING

counter = 0;
sinSum = 0;

while counter<29
    
    freq = frequency*(counter+1);
    
    sinus = sin(2*pi*t*freq);
    
    sinSum = sinSum + sinus;
    
    counter = counter + 1;
end    


[b,a] = butter(2, Wn1, 'bandpass');

f1 = filter(b,a,sinSum);

[b2,a2] = butter(2, Wn2, 'bandpass');

f2 = filter(b2,a2,sinSum);

[b3,a3] = butter(2, Wn3, 'bandpass');

f3 = filter(b3,a3,sinSum);

f1mag =  db2mag(-1);
f2mag =  db2mag(-5);
f3mag =  db2mag(-28);

f1 = f1.*f1mag;
f2 = f2.*f2mag;
f3 = f3.*f3mag;

ljud = (f0+f1+f2+f3);

ljud = ljud/(max(abs(ljud)));

% ljud = ljud.*fadeVector;

p = audioplayer(ljud, Fs);
playblocking(p);
