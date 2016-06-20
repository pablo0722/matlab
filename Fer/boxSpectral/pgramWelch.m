function [px,wx] = pgramWelch(x,L,over,win)
%PGRAMWELCH
%   [px,wx] = pgramWelch(x,L,over,win)
%   x:      (in)    Senal a analizar
%   L:      (in)    Tamano de las ventanas
%   over:   (in)    Solapamiento [0,1)
%   win:    (in)    Ventana a utilizar
%       Las opciones son 'rect' 'tr' 'hann' 'flat' 'bh'
%
%   px:     (out)   Densidad espectral de energia
%   wx:     (out)   Vector de frecuencias normalizada [0,pi]
%
%   La funcion PGRAMWELCH calcula el estimador PERIODOGRAMA de la
%   densidad espectral de energia de la senal x usando parte de la funcion
%   PGRAMMODIFIED
%   
%   See also PGRAM PGRAMMODIFIED
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 06/10/2015
    
    if (over >= 1) | (over < 0)
        error('Overlap is invalid')
    end;
    
    n1 = 1;
    n0 = (1-over)*L;
    n = 1 + floor( (length(x)-L) / n0 );
    
    [px,wx] = pgramModified(x,win,n1,n1+L-1);
    px = px./n;
    n1 = n1 + n0;
    
    for i = 2:n
        px = px + pgramModified(x,win,n1,n1+L-1)./n;
        n1 = n1 + n0;
    end;
end