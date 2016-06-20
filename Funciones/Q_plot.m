function [ transformada, f ] = Q_plot( signal, base, R, Fs, N, f0, b, factor )
    %% DPDT_plot
    % DPDT_plot realiza la transformada de DPDT de signal, se debe
    % disponer previamente de la matriz base de la trasformada.
    
    P = 2^(1/b);


    %% Analisis previo de la signal
    % Elimino la constante a la señal de entrada para que no interfiera en
    % el espectro ya que esta transformada no contempla la continua.
    signal = signal - sum(signal)/N;
    
    
    %% Calculo de la DPDT
    transformada = (1./R).*(signal*base);
    
    
    %% Genero eje de frecuencias
    Ts=1/Fs;
    t=0:(1/Fs):((N-1)*Ts);
    i = 0:length(transformada)-1;
    f(i+1) = f0*P.^i; % creo vector de 0 a 1 a pasos de NDFT/2+1
        
    
    %% Ploteo
    figure;
    subplot(311);
        plot(t,signal);
        title('señal bajo estudio');
    subplot(312);
        stem(f,abs(transformada).^factor); hold on
        [m, i] = max_relativos(abs(transformada).^factor, 0.025);
        stem(f(i),m, 'r'); hold off     % Ploteo en rojo algunos maximos
        title('transformada Q Constante');
        xlabel('frecuencia en Hz');
        ylabel('modulo');

        
    %% Opcional para el estudio de fase
    y = transformada;
    p = unwrap(angle(y));                  % Fase
    f_ang = (0:length(y)-1)/length(y)*100; % Eje de frecuencias
    subplot(313);stem(f_ang,p)
    xlabel ('frecuencia en Hz')
    ylabel ('fase en radianes')
    
    
    %% Imprimo maximos encontrados (ploteados en rojo)
    a1 = (1:length(m))';
    a2 = m';
    a3 = f(i)';
    display([(ones(length(a1),1))*'Maximo_' num2str(a1) (ones(length(a1),1))*': ' num2str(a2) (ones(length(a1),1))*' - ' num2str(a3) (ones(length(a1),1))*' Hz']);

end