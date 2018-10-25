function y2 = limiter(y2, gain)

y2 = y2 * gain;
y2(y2 < -1) = -1;
y2(y2 > 1) = 1;

end

