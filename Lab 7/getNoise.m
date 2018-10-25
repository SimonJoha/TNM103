function y2 = getNoise(seq)

x = sgolayfilt(seq, 2, 27);
y2 = seq + x * -1;

end

