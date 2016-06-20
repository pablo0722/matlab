function [ y ] = compressor( x,m )
%COMPRESSOR Decimacion
%   [y] = COMPRESSOR(x,m)
%   x:  (in)    Senal a decimar
%   m:  (in)    Factor de decimacion, se descartan una de cada M-1 muestras
%   y:  (out)   Senal decimada y filtrada LPF
%
%   La funcion COMPRESSOR toma la senal de analisis x y la decima por un
%   factor M, tomando una de cada M-1 muestras. Por ejemplo, si M = 2, se
%   analizan todas las muestras impares de la senal x, es decir x[1], x[3],
%   x[5], ...
%
%   Para evitar el alias que se produce al decimar, producto de la
%   expansion del espectro, la senal x es previamente filtrada con un
%   filtro pasa bajos cuyas caracteristicas son:
%           wp = 0.8/m
%           wst = 1.2/m
%           ap = 0.001
%           ast = 80
%
%   La senal y es el resultado de la decimacion.
%
%   See also downSampler upSampler reSampler expander
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 01/12/2015

    if (m == 1)
        y = x;
        return;
    end
    
    wp = 0.8/m;
    wst = 1.2/m;
    ap = 0.001;
    ast = 80;
    d = fdesign.lowpass('Fp,Fst,Ap,Ast',wp,wst,ap,ast);
    hd = design(d); 

    y = filtfilt(hd.Numerator,1,x);
    y = downSampler(y,m);
    
end