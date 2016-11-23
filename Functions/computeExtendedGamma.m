function [ output ] = computeExtendedGamma( x, input )
%COMPUTEEXTENDEDGAMMA Compute an extended gamma function, for fitting.

bias = x(1);
gain = x(2);
minL = x(3);
maxL = x(4);
gamma = x(5);

% out = bias + gain * ( ((in-minL) / (maxL-minL)) .^ gamma );

output = minL + (maxL - minL) * (((input - bias)/gain) .^ (1/gamma));

end

