function signalForReverb = schroederAllpass(signalForReverb, reverbLength, reverbGain, Fs)
    signalForReverb = allpass(signalForReverb, reverbLength, reverbGain);
end

