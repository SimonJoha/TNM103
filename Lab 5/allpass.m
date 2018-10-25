function [reverbedSound] = allpass(x, reverbLength, reverbGain)

    b = zeros(1, reverbLength + 1);
    b(1) = -reverbGain;
    b(reverbLength + 1) = 1;
    
    a = zeros(1, reverbLength + 1);
    a(1) = 1;
    a(reverbLength + 1) = -reverbGain;
    
    reverbedSound = filter(b, a, x);
    
end 