function [ transformada, f ] = Q( signal, base, R, Fs, N, f0, b, factor, ventana )
    %% DPDT_plot
    % DPDT_plot realiza la transformada de DPDT de signal, se debe
    % disponer previamente de la matriz base de la trasformada.
    
    P = 2^(1/b);

    %% Analisis previo de la signal
    % Elimino la constante a la señal de entrada para que no interfiera en
    % el espectro ya que esta transformada no contempla la continua.
    signal = signal - sum(signal)/N;
    
    
    %% Calculo de la DPDT
    if ventana
        % Aplico ventaneo a la signal
        transformada = zeros(1,size(base,2));
        for i = 1:size(base,2);
            aux_signal = signal .* [hamming(sum(base(:,i)~=0))' zeros(1, length(signal)-(sum(base(:,i)~=0)))];
            transformada(i) = ((1./R(i)).*(aux_signal*base(:,i))).^factor;
        end
    else
        transformada = ((1./R).*(signal*base)).^factor;
    end
    
    
    %% Genero eje de frecuencias
    i = 0:length(transformada)-1;
    f(i+1) = f0*P.^i; % creo vector de 0 a 1 a pasos de NDFT/2+1
    
end