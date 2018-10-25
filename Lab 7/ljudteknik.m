load gong;
y1 = zeros(length(y), 1);

for i = 500:length(y)
    y1(i) = y(i-499);
end

% Add as L/R channels
y2 = [y, y1];

% Original signal (mono)
soundsc(y, Fs);

% Stereo delay
soundsc(y2, Fs);