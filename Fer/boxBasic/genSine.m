function s = genSine(amp,fo,phase,fs,samples)
%GENSINE genera una senal senoidal cuyos parametros son
%   amp     => amplitud de la senal senoidal
%   fo      => frecuencia
%   phase   => fase incial
%   fs      => frecuencia de muestreo
%   samples => numero de muestras de la senal
%
%   Example
%       genSine(1,10,0,100,256)
%
%   Genera una senal senoidal de
%       Amplitud    = 1
%       Frecuencia  = 10 Hz
%       Fase        = 0 rad
%       F. Muestreo = 100 Hz
%       Muestras    = 256 muestras
%
%   See also genSquare genTriangle
%
%   Autor: Orge Fernando Gabriel
%   Revision: 4  
%   Fecha: 11/04/2016

    ts = 1/fs;
    t = 0 : ts : ts*(samples-1);
    s = amp*sin(2*pi()*fo.*t + phase);
    s = s';
end 