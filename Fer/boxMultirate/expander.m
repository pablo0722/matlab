function [ y ] = expander( x,l )
%EXPANDER interpolacion
%   [y] = EXPANDER(x,l)
%   x:  (in)    Senal a interpolar
%   l:  (in)    Factor de interpolacion, se insertan L-1 ceros
%   y:  (out)   Senal interpolada y filtrada LPF
%
%   La funcion EXPANDER toma la senal de analisis x y la interpola por un
%   factor L, intercalando una de cada L-1 muestras. 
%   Por ejemplo, si L = 2, se intercala una muestra entre cada muestra de
%   la senal original, si x = [x1 x2 x3 .. xn], la senal y tendra la
%   siguiente forma, y = [x1 ya x2 yb x3 yc .. xn].
%
%   Puesto que al intercalar ceros en la senal x el espectro de frecuencias
%   se replica en funcion de la cantidad de ceros, sera necesario filtrar
%   la senal luego de intercalar los ceros. Adicionalmente este filtro pasa
%   bajos genera los valores que deben ir en lugar de los ceros.
%
%   Las caracteristicas del filtro LPF son las siguientes:
%           wp = 0.8/m
%           wst = 1.2/m
%           ap = 0.001
%           ast = 80
%
%   La senal y es el resultado de la interpolacion.
%
%   See also downSampler upSampler reSampler expander
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 01/12/2015

    if (l == 1)
        y = x;
        return;
    end
    
    wp = 0.8/l;
    wst = 1.2/l;
    ap = 0.001;
    ast = 80;
    d = fdesign.lowpass('Fp,Fst,Ap,Ast',wp,wst,ap,ast);
    hd = design(d); 

    y = upSampler(x,l);    
    y = l*filtfilt(hd.Numerator,1,y);
    
end