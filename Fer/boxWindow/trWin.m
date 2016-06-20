function w = trWin(L)
%TRWIN 
%   Genera una ventana triangular de longitud L. 
%
%   See also hannWin flatWin bhWin
%
%   Autor: Orge Fernando Gabriel
%   Revision: 2
%   Fecha: 
    w = [];
    n = 1 : L;
    
    if mod(L,2) == 1        % impar (odd)
        centerEvenA = (L+1)/2;    
        centerOddB = (L+1)/2 + 1;
        w(1:centerEvenA) = 2*n(1:centerEvenA)/(L+1);
        w(centerOddB:L) = 2 - 2*n(centerOddB:L)/(L+1);
    else % even
        centerEvenA = L/2;    
        centerEvenB = L/2 + 1;
        w(1:centerEvenA) = (2*n(1:centerEvenA) - 1)/L;
        w(centerEvenB:L) = 2 - (2*n(centerEvenB:L) - 1)/L;
    end
    w = w';
end