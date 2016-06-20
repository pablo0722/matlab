function [ transformada, f ] = DPDT( signal, b, R, Fs, N, P0, P, factor )
    %% DPDT_plot
    % [ transformada, f ] = DPDT( signal, b, R, Fs, N, P0, P, factor )
    % DPDT_plot realiza la transformada de DPDT de signal, se debe
    % disponer previamente de la matriz base de la trasformada.


    %% Analisis previo de la signal
    % Elimino la constante a la señal de entrada para que no interfiera en
    % el espectro ya que esta transformada no contempla la continua.
    signal = signal - sum(signal)/N;
    

    
    %% Calculo de la DPDT
    transformada = ((1/R)*(signal*b)).^factor;
    
    
    %% Genero eje de frecuencias
    i = 0:length(transformada)-1;
    f(i+1) = P0*P.^i; % creo vector de 0 a 1 a pasos de NDFT/2+1
            

end