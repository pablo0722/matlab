function [y fs] = flanger(filename, depth, rango, frec, delay)
% [y] = flanger(fs, v, x, r)
% Efecto de flanging (siempre la muestra de flanging es anterior a la actual)
%
% filename:     Nombre del archivo .wav a analizar
% depth = 0.8:  Amplitud del efecto
% rango = 100:  Retraso variable maximo en numero de muestras
% frec = 0.1:   Frecuencia del retrazo variable
% delay = 0:    Retraso fijo en numero de muestras
%
% y:    Audio con flanger
% fs:   Frecuencia de muestreo
%
%
%Version 1.0
%Coded by: Stephen G. McGovern, date: 08.03.03

    if ~exist('depth', 'var')
        depth = 0.8;    % Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
    end
    if ~exist('rango', 'var')
        rango = 100;    % Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
    end
    if ~exist('frec', 'var')
        frec = 0.1;    % Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
    end
    if ~exist('delay', 'var')
        delay = 0;    % Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
    end
    
    [in, fs] = wavread(filename);   % Cargo audio
    in = in(:,1);                   % Tomo un solo canal
    in = in/max(abs(in));           % Normalizo amplitud
    
    y = in;
    
    rango_a = abs(rango);
    delay = abs(delay);
    rango = abs(rango);
    
    first = ceil(1+delay+rango_a);
    delay = delay + rango_a;
    last = floor(length(in)-rango_a+delay);
    
    for i = first : last
        current = i;
        current = current - delay;                      % retraso fijo
        current = current + floor(rango*cos(2*pi*frec*i/fs));  % retraso variable
        current = floor(current);
        y(i) = in(i) + depth*in(current);
    end
    
    y = y/max(abs(y));
    
end