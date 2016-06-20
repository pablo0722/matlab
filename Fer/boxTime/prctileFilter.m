function [ y ] = prctileFilter( x , n , p )
%PRCTILEFILTER 
%   [y] = prctileFilter( x , n , p )
%   x:  (in)    Senal a filtrar
%   n:  (in)    Orden del filtro / Tamano de la ventana [en muestras]
%   p:  (in)    Percentil [0 .. 100] 
%   y:  (out)   Senal de salida (filtrada)
%
%   Cuando p = 50, a funcion PRCTILEFILTER calcula el filtro de mediana de
%   la senal de entrada x con una ventana de tamano n. Cuando p es distinto
%   de 50, la funcion implementa el mismo algoritmo pero con el percentil
%   ingresado.
%   
%   See also 
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 31/10/2015

    if mod(n,2) == 0
      %number is even
      infLim = -(n/2);
      supLim = (n/2) - 1;
      pad = n/2;
    else
      %number is odd
      infLim = -(n-1)/2;
      supLim = (n-1)/2;
      pad = (n-1)/2;
    end
    
    if ( ~isrow(x) )
        x = x';
    end
    
    xx = [zeros(1,pad)  x  zeros(1,pad)];
        
    for k = 1 : length(x)
        y(k) = prctile( xx( (k+infLim+pad) : (k+supLim+pad) ) , p);
    end

    y = y';
end

