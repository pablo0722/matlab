function w = flatWin(L)
%FLATWIN 
%   Genera una ventana FLATTOP de longitud L.
%
%   See also triangularWin hannWin bhWin
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1  
%   Fecha: 
    w = [];
    n = 0 : L-1;
    
    a0 = 0.21557895;
    a1 = 0.41663158;
    a2 = 0.277263158;
    a3 = 0.083578947;
    a4 = 0.006947368;
    
    w = a0 - a1*cos(2*pi().*n/(L-1)) + a2*cos(4*pi().*n/(L-1)) ...
           - a3*cos(6*pi().*n/(L-1)) + a4*cos(8*pi().*n/(L-1));
	w = w';
    
end