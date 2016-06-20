function qs = quantizeSignal(s,nBits)
%QUANTIZESIGNAL cuantiza la senal s en nBits niveles
%
%   Example
%       quantizeSignal(s,8)
%
%   La senal qs es la forma cuantizada de la señal s en 8 bits igual a 256
%   niveles discretos
%
%   See also 
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1  
%   Fecha: 31/08/2015

    qs = [];
    kAdcPos = 2^(nBits-1) - 1;
    kAdcNeg = 2^(nBits-1);
    for ii = 1 : length(s)
        if s(ii) >= 0 
            qs(ii) = (1/kAdcPos)*round(kAdcPos*s(ii));
        else
            qs(ii) = (1/kAdcNeg)*round(kAdcNeg*s(ii));
        end
    end
end