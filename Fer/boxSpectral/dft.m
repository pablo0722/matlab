function y = dft(x)
%DFT 
%   Calcula la transformada discreta en tiempo discreto de una señal x 
%   El algoritmo NO escala.
%
%   See also magSpectrum magSpectrumDB phaseSpectrum
%
%   Autor: Orge Fernando Gabriel
%   Revision: 2  
%   Fecha: 28/08/2015

    len = length(x);
    w = 1 : 1 : len;
    y = zeros(1,len);
    for k = 0 : 1 : len-1
        e = exp(-2*pi()*1i*k.*w/len);
        y(k+1) = e*x;
    end

    y = y';
end