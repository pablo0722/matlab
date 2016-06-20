function noise = noise_generator(maximo, tiempo, fs)
% noise = noise_generator(maximo, tiempo, fs)
% Genera ruido segun una frecuencia de muestreo
%
% tiempo:   Medido en segundos
% fs:       Frecuencia de muestreo
% p:        Potencia del ruido en dB
% maximo:   Valor maximo del ruido

    noise = wgn(fs*tiempo, 1, 0);
    noise = (noise/max(noise))*maximo;

end