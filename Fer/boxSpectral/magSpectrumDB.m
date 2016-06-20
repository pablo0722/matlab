function [fv,ms] = magSpectrumDB(x)
%MAGSPECTRUMDB
%   Similar a magSpectrum, salvo por el hecho de que calcula los valores en
%   dB en lugar de ser valores absolutos.
%
%   Example 
%
%   See also magSpectrum phaseSpectrum 
%
%   Autor: Orge Fernando Gabriel
%   Revision: 3  
%   Fecha: 11/04/2016

    len = length(x);
    df = 1/len;
    f = 0 : df : df*(len-1);
    ms = 20*log10( 2*abs( (1/len)*x(1:end/2) ) );
    f = f(1:end/2)';
    
end