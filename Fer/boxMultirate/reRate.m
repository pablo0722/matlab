function [ y ] = reRate( x,k )
%RERATE Remuestrea la senal a la frecuencia deseada
%   [ y ] = reRate( x,l,m,fs )
%   x:  (in)   Senal a remuestrear
%   k:  (in)   Factor de remuestreo
%   y:  (out)  Senal remuestreada
%
%   La funcion reRate remuestrea la senal x a la frecuencia dada por
%       fs' = k * fs
%   
%   
%   See also compressor downSampler expander upSampler
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 21/11/2015


    [n,d] = rat(k);     % aproxima k como cociente de enteros
    nF = factor(n);     % obtiene la factorizacion de n...
    dF = factor(d);     % ... los ordena de menor a mayor
    
    lnF = length(nF);
    ldF = length(dF);
    
    % Se pretende que la cantidad de factores de cada numero sea la misma
    % Cuando no lo sea, se llenará con 1s hasta en tanto se equiparen
    if lnF > ldF
        aux = ones(1,lnF-ldF);
        dF  = [aux dF];
    else
        aux = ones(1,ldF-lnF);
        nF  = [aux nF];
    end
    
    % En este punto los vectores nF y dF de factores de n y d respectiva...
    % ...mente tienen sus factores ordenados de menor a mayor.
    %
    % Se buscara implementar el remuestro siguiendo el siguiente esquema
    %   UP->LPF->DOWN ==> UP->LPF->DOWN ==> UP->LPF->DOWN
    %
    % Al ordenar los factores de menor a mayor y al completar la cantidad
    % de factores para equiparlos es posible implementar las parejas de
    % upSampleo y downSampleo.
    %
    % Por ejemplo, para valores 
    %   nF = 3 3 5
    %   dF = 1 2 7
    %
    % La frecuencia mas critica es 1/7, pues es la menor de todas, luego,
    % lo ideal sera que el unico filtro a aplicar tenga esa frecuencia de
    % corte y utilizar solo es filtro para la cadena completa.
        
    dF = fliplr(dF); % cambia el orden, ahora estan de mayor a menor
    nF = fliplr(nF); % cambia el orden, ahora estan de mayor a menor
    
    maxFactor = max(max(nF,dF));
    
    if (maxFactor == 1)
        y = x;
        return;
    end
    
    wp = 0.8/maxFactor;
    wst = 1.2/maxFactor;
    ap = 0.001;
    ast = 80;
    d = fdesign.lowpass('Fp,Fst,Ap,Ast',wp,wst,ap,ast);
    hd = design(d); 

    y = x;
    len = length(nF);
    for ii = 1:len
        y = upSampler(y,nF(ii));
        y = nF(ii) * filtfilt(hd.Numerator,1,y);
        y = downSampler(y,dF(ii));
    end
    
end