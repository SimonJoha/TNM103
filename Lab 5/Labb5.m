clear
close all
clc

[x, Fs] = audioread('AnalogRytm_120BPM.wav');
[goal, Fs2] = audioread('TimeFactor_RE501_120BPM.wav');
t = (0:1/Fs:1);
counter = 0;

% plot(x);
hold on
% figure
plot(goal)

delayMs = 375; % ms
% 
y1 = delay(x, delayMs, 0.5, Fs);
y1 = y1 + delay(y1, delayMs, 0.25, Fs);
y1 = y1 + delay(y1, delayMs, 0.12, Fs);

% y1 = highpass(y1, 0.5);
y1 = x + 0.5 * y1;
y1 = y1 / (max(abs(y1)));


% figure
plot(y1, 'b')
plot(x, 'y')

y1 = reverb(x, Fs); 
p = audioplayer(y1, Fs);
playblocking(p);

% Need to add delay, reverb, high pass filter
% tempo, rumseffekt (reverb), brus, jordbrum 50Hz
% distrotion