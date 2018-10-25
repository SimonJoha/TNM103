function signalForReverb = reverb(signalForReverb, Fs)
%SCH Summary of this function goes here
%   Detailed explanation goes here
    reverbGain = 0.7;
    numAllpass = 3;
    reverbTime = 100;

    for i = 0:numAllpass-1
        reverbLength = ceil((reverbTime / 1000) * Fs / (3^i));
        signalForReverb = [signalForReverb; zeros(abs(reverbTime / 100) * Fs, 2)];
        signalForReverb = allpass(signalForReverb, reverbLength, reverbGain);
    end
end

