function [f,ms] = magSpectrum(x)
%MAGSPECTRUM
%   Calcula el espectro de modulo de una senal temporal x cuya frecuencia 
%   de muestreo es fs. Como resultado se obtiene un vector de frecuencias
%   y el espectro de modulo para cada una de esas frecuencias dentro del
%   vector generado. El espectro es exclusivamente de frecuencias
%   positivas.
%
%   Ultima revision: El algoritmo toma como entrada una senal a la que se
%   le calculo la dft/fft SIN ESCALAR, luego para que el espectro calculado
%   se ajuste a la energia real que deberia tener la senal, el vector de
%   salida ms se escala en funcion de la cantidad de muestras de la senal.
%
%   Tanto el vector correspondiente al espectro de magnitud como el vector
%   de frecuencias contienen las frecuencias de interes (positivas), hasta
%   fn = fs/2. La parte alta del espectro no se contempla. No obstante, la 
%   energía de la senal es contenida completamente.
%
%   Example 
%
%   See also magSpectrumDB phaseSpectrum
%
%   Autor: Orge Fernando Gabriel
%   Revision: 3  
%   Fecha: 28/10/2015

    len = length(x);
    df = 1/len;
    f = 0 : df : df*(len-1);
    ms = 2*abs( (1/len)*x(1:end/2) ) ;
    f = f(1:end/2)';
end