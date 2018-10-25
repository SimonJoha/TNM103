clear
close all
clc

[y, Fs] = audioread('forensisktljud.wav');

seqHard = y(3*Fs:8*Fs, :); % Jag skulle behöva köpa lite mer ljud till en kurs jag håller på och lär studenter
% seqHard = y(15*Fs:20*Fs, :); % Då har vi den här modellen ....
seqHardWN = sgolayfilt(seqHard, 6, 27);

[b, a] = butter(6, 200/(Fs/2), 'high');
seqHardWNH = filter(b, a, seqHardWN);
seqHardWNH = seqHardWNH * 10;
seqHardWNH(seqHardWNH > 1) = 1;
seqHardWNH(seqHardWNH < -1) = -1;

% % "Complete" sequence with multiple cuts
% % Noise cuts can be heard
% seq = y(24*Fs:42*Fs, :);
% y4 = getNoise(seq);
% y4 = limiter(y4, 10);
% figure
% plot(y4);
% 
% % First noise
% seq2 = y(24*Fs:27*Fs, :);
% y2 = getNoise(seq2);
% y2 = limiter(y2, 10);
% figure
% plot(y2);
% audpow(y2, Fs);
% 
% % Second noise
% seq3 = y(35*Fs:38*Fs, :);
% y3 = getNoise(seq3);
% y3 = limiter(y3, 10);
% figure
% plot(y3);
% audpow(y3, Fs);
% 
% % Plot difference between the noises
% % Major difference
% figure
% plot(y3);
% hold on
% plot(y2);
% 
% % Low-pass filtered signal
% % Will not tell very much
% [b, a] = butter(6, 500/(Fs/2));
% lpSeq = filter(b, a, seq);

% Play signal
p = audioplayer(seqHardWNH, Fs);
playblocking(p);