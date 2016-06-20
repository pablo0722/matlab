function [s] = genTriangle(amp,fo,symm,fs,samples)
%GENTRIANGLE genera una senal triangular cuyos parametros son
%   amp     => amplitud de la senal senoidal
%   fo      => frecuencia
%   symm    => simetria o punto donde cambia la pendiente (0,1)
%   fs      => frecuencia de muestreo
%   samples => numero de muestras en el vector 
%
%   Example
%       genSquare(1,10,0.5,100,256)
%
%   Genera una senal triangular de
%       Amplitud    = 1
%       Frecuencia  = 10 Hz
%       Simetria    = 0.5 (50%)
%       F. Muestreo = 100 Hz
%       Muestras    = 256 muestras
%
%   See also genSine genSquare
%
%   Autor: Orge Fernando Gabriel
%   Revision: 5  
%   Fecha: 11/04/2015

    if (symm <= 0) || (symm >= 1)
        error('Simetry error, must be: 0 < symm < 1');
    end
    
    to = 1/fo;
    ts = 1/fs;
    t = 0 : ts : ts*(samples-1);
    
    tOn  = symm*to;
    mOn  = amp/tOn;
    mOff = amp/(to-tOn);
    
    for ii = 1:length(t)
        if rem(t(ii),to) < symm*to
            s(ii) = mOn*rem(t(ii),to);
        else
            s(ii) = (mOn+mOff)*tOn - mOff*mod(t(ii),to);
        end
    end
    
    s = s';
end 