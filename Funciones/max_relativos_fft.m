function [maximo, potencia] = max_relativos_fft(signal_t, Fs, min_dif)
% max_relativos_fft Detecta los maximos relativos de la fft de una se�al
%
% [maximo, potencia] = max_relativos_fft(signal_t, Fs, min_dif)
% signal_t:     se�al de entrada
% Fs:           frecuencia de muestreo
% min_dif:      diferencia minima entre el 'promedio' y la 'nota' (para eliminar ruido)
% [maximo]:     Vector de indices de los maximos relativos de la fft de la se�al
% [potencia]:   Vector de los maximos relativos de la fft de la se�al
%
% For more information, see <a href="https://sourceforge.net/p/dplabaudio/wiki/Home/">Wiki del DPLab-Audio</a>.
%
% See also max_fft, max_relativos, max_max_fft, mayores, plotFFT, tono, tono_con_armonicos, tono_ruido.
%
% Version 1.0 01-10-2014

    [f d] = fft_abs(signal_t, numel(signal_t), Fs);

    [potencia,I]=max_relativos(d,min_dif);       % obtengo los maximos relativos de la fft de la se�al y sus respectivos indices

    start = 0;
    for i = 1:length(I)
        if start == 0
            maximo = f(I(i));          % posicion en el vector de frecuencias
            start = 1;
        else
            maximo = [maximo f(I(i))];          % posicion en el vector de frecuencias
        end
    end

    if start == 0
        maximo = [];
    end
end