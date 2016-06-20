function w = bhWin(n)
%BHWIN 
%   Genera una ventana BLACKMAN-HARRIS de longitud L.
%
%   See also triangularWin hannWin flatWin
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1  
%   Fecha: 
    k = 0 : n-1;
    a0 = 0.35875;
    a1 = 0.48829;
    a2 = 0.14128;
    a3 = 0.01168;
    w = a0 - a1*cos(2*pi().*k/(n-1)) + a2*cos(4*pi().*k/(n-1)) ...
           - a3*cos(6*pi().*k/(n-1));
    w = w';
end