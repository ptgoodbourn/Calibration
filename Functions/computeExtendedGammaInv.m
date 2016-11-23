function [ output ] = computeExtendedGammaInv( x, input )
%COMPUTEEXTENDEDGAMMA Compute an inverse extended gamma function, for fitting.

bias = x(1);
gain = x(2);
minL = x(3);
maxL = x(4);
gamma = x(5);

output = bias + gain * ( ((input-minL) / (maxL-minL)) .^ gamma );

end

