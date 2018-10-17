function y = delay(x, delayMs, volume, Fs)
    y = zeros(length(x), 1);
    delay = round(delayMs / 1000 * Fs);
    
    for i = 1:length(y) - delay
        y(i + delay) = y(i + delay) + volume * x(i);
    end
end

