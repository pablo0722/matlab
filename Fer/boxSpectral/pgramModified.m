function [px,wx] = pgramModified(x,w,n1,n2)
%PGRAMMODIFIED
%   [px,wx] = pgramModified(x,w,n1,n2)
%   x:  (in)    Senal a analizar
%   w:  (in)    Ventana a utilizar
%       Las opciones son 'rect' 'tr' 'hann' 'flat' 'bh'
%   n1: (in)    Extremo inferior del bloque en estudio
%   n2: (in)    Extremo superior del bloque en estudio
%   px: (out)   Densidad espectral de energia
%   wx: (out)   Vector de frecuencias normalizada [0,pi]
%
%   La funcion PGRAMMODIFIED calcula el estimador PERIODOGRAMA de la
%   densidad espectral de energia de la senal x(n1:n2) haciendo uso de la
%   ventana w, para mejorar alguna de sus caracteristicas de estimacion.
%   Concretamente mejora la resolucion en frecuencia dependiendo de la
%   ventana utilizada
%   
%   Para su calculo hace uso de la funcion PGRAM
%
%   See also PGRAM
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 06/10/2015
    
    if nargin == 1
        n1 = 1; n2 = length(x);
        w = 'rect';
    end;
    if nargin == 2
        n1 = 1; n2 = length(x);
    end;
    N = n2 - n1 + 1;
    
    if (strcmp(w,'rect'))       win = ones(N,1); % default window
    elseif (strcmp(w,'tr'))     win = trWin(N);
    elseif (strcmp(w,'hann'))   win = hannWin(N);
    elseif (strcmp(w,'flat'))   win = flatWin(N);
    elseif (strcmp(w,'bh'))     win = bhWin(N);
    end;

    xw = x(n1:n2).*win;
	[px,wx] = pgram(xw); 
    px = (N/sum(win.^2))*px;
    
end