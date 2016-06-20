function w = hannWin(n)
%HANNWIN 
%   Genera una ventana HANNING de longitud L.
%
%   See also triangularWin flatWin bhWin
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1  
%   Fecha: 

    k = 0 : n-1;
    w = 0.5 * (1 - cos(2*pi().*k / (n-1)));
    w = w';
end