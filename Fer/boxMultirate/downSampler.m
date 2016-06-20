function [ y ] = downSampler( x,m )
%DOWNSAMPLER downSampler
%   [y] = DOWNSAMPLER(x,m)
%   x:  (in)    Senal a decimar
%   m:  (in)    Factor de decimacion, se descartan una de cada M-1 muestras
%   y:  (out)   Senal decimada SIN filtrado LPF
%
%   La funcion DOWNSAMPLER toma la senal de analisis x y la decima por un
%   factor M, tomando una de cada M muestras. Por ejemplo, si M = 2, se
%   conservan todas las muestras impares de la senal x, es decir x[1], 
%   x[3], x[5], ...
%
%   No filtra previamente la senal, con lo cual no EVITA aliasing!!!
%
%   See also upSampler reSampler compressor expander
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 01/12/2015
    
    if (m == 1)
        y = x;
        return;
    end
    
    y = [];
    if mod(length(x),m) > 0
        limit = length(x)/m + 1;
    else
        limit = length(x)/m;
    end

    for ii = 1 : limit
        y(ii) = x(m*(ii-1)+1);
    end
    y = y';

end