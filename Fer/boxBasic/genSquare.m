function [s] = genSquare(amp,fo,duty,fs,samples)
%GENSQUARE genera una senal cuadrada cuyos parametros son
%   amp     => amplitud de la senal senoidal
%   fo      => frecuencia
%   duty    => ciclo de actividad (0,1]
%   fs      => frecuencia de muestreo
%   samples => numero de muestras en el vector 
%
%   Example
%       genSquare(1,10,0.5,100,256)
%
%   Genera una senal senoidal de
%       Amplitud    = 1
%       Frecuencia  = 10 Hz
%       Ciclo Act.  = 0.5 (50%)
%       F. Muestreo = 100 Hz
%       Muestras    = 256 muestras
%
%   See also genSine genTriangle
%
%   Autor: Orge Fernando Gabriel
%   Revision: 4  
%   Fecha: 11/04/2016

    if (duty <= 0) || (duty > 1)
        error('Duty error, must be: 0 < duty <= 1');
    end
    
    to = 1/fo;
    ts = 1/fs;
    t = 0 : ts : ts*(samples-1);
    
    for ii = 1:1:samples
        if rem(t(ii),to) < duty*to
            s(ii) = amp;
        else
            s(ii) = 0;
        end
    end
    
    s = s';
end 