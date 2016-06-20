function [ transformada, f ] = DFT_plot( signal,b,R,Fs,N,factor )
    %% DFT_plot
    % DFT_plot realiza la transformada de fourier de signal, se debe
    % disponer previamente de la matriz base de la trasformada.


    %% Calculo de la DFT
    transformada = (1/R)*(signal*b);
    transformada = transformada(1:N/2+1);

    
    %% Genero eje de frecuencias
    Ts=1/Fs;
    t=0:(1/Fs):((N-1)*Ts);
    f = Fs/2*linspace(0,1,N/2+1); % creo vector de 0 a 1 a pasos de NDFT/2+1
    
    
    %% Ploteo
    figure;
    subplot(311);
        plot(t,signal);
        title('señal bajo estudio');
    subplot(312);
        stem(f, abs(transformada).^factor); hold on;
        [m, i] = max_relativos(abs(transformada).^factor, 0.07);
        stem(f(i),m, 'r'); hold off;    % Ploteo en rojo algunos maximos
        title('transformada discreta de Fourier');
        xlabel('frecuencia en Hz');
        ylabel('modulo');
        

    %% Opcional para el estudio de fase
    y = transformada;
    p = unwrap(angle(y));                   % Fase
    f_ang = (0:length(y)-1)/length(y)*100;  % Eje de frecuencias
    subplot(313);
    plot(f_ang,p);
    xlabel('frecuencia en Hz');
    ylabel('fase en radianes');
    
    
    %% Imprimo maximos encontrados (ploteados en rojo)
    a1 = (1:length(m))';
    a2 = m';
    a3 = f(i)';
    display([(ones(length(a1),1))*'Maximo_' num2str(a1) (ones(length(a1),1))*': ' num2str(a2) (ones(length(a1),1))*' - ' num2str(a3) (ones(length(a1),1))*' Hz']);
    
end