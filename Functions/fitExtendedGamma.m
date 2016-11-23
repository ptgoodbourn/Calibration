function [ err, constraint ] = fitExtendedGamma( x, values, measurements )
%FITEXTENDEDGAMMA Adaptation of Psychtoolbox's FitGammaExtP by dhb. Uses
%Psychtoolbox's ComputeFSSE.

    predicted = computeExtendedGamma(x,values);
    err = ComputeFSSE(measurements',predicted');
    constraint = -x;

end

