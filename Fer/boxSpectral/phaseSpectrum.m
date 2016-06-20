function [f,ps] = phaseSpectrum(x)
%PHASESPECTRUM
%   Calcula el espectro de fase de una senal temporal x cuya frecuencia 
%   de muestreo es fs. Como resultado se obtiene un vector de frecuencias
%   y el espectro de fase para cada una de esas frecuencias dentro del
%   vector generado. El espectro es exclusivamente de frecuencias
%   positivas.
%
%   Example 
%
%   See also magSpectrum magSpectrumDB
%
%   Autor: Orge Fernando Gabriel
%   Revision: 3  
%   Fecha: 11/04/2016
    
    len = length(x);
    df = 1/len;
    f = 0 : df : df*(len-1);
    ps = angle( x(1:end/2) );
    f = f(1:end/2)';

end