function [ y ] = upSampler( x,l )
%UPSAMPLER upSampler
%   [y] = UPSAMPLER(x,l)
%   x:  (in)    Senal a interpolar
%   l:  (in)    Factor de expansion, se agregan L-1 ceros entre c/ muestra
%   y:  (out)   Senal expandida SIN filtrado LPF
%
%   La funcion UPSAMPLER toma la senal de analisis x y la expande por un
%   factor L, agregando un cero cada L-1 muestras. Por ejemplo, si L = 2 y
%   la señal x[n] = [1 2 3 4 5], la senal de salida y[n] = [1 0 2 0 3 ...].
%
%   No filtra posteriormente la senal, se debe tener presente la proximidad
%   de las replicas ahora que el eje de frecuencia se ha comprimido.
%
%   See also downSampler reSampler compressor expander
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 01/12/2015

    if (l == 1)
        y = x;
        return;
    end
   
    y = zeros( 1 , l*length(x) );
    ii = 1;
    jj = 1;
    while ii < length(y)
        y(ii) = x(jj);
        ii = ii + l;
        jj = jj + 1;
    end
    y = y';

end