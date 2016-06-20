function [diffe,mse] = errorResta(x,y)
%ERRORRESTA
%   [e,em] = errorResta(x,y)
%   x:     (in)    Senal que se desea comparar
%   y:     (in)    Senal con la que se desea comparar x
%   diffe: (out)   Error punto a punto, obtenido como la diferencia
%   mse:   (out)   Error cuadratico medio
%
%   Calcula el error que se comete al querer estimar el
%   vector de resultados y a partir del vector de predicciones x
%
%   mse es el valor medio de los errores cometidos punto a punto
%   diffe es el vector de resultados punto a punto entre x e y
%
%   See also  
%
%   Autor: Orge Fernando Gabriel
%   Revision: 2
%   Fecha: 11/04/2016
    lenx = length(x);
    leny = length(y);
    if (lenx ~= leny)
        error('Los vectores deben ser de la misma dimension');
    end
    
    diffe = abs(x - y);
    mse   = sum(diffe.^2)/lenx;

end