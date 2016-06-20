function [DAFx_Harm DAFx_Perc fs] = Separador_Arm_Perc(filename, window_lenth, salto, harm_filter_order, perc_filter_order)
% [DAFx_Harm DAFx_Perc] = Separador_Arm_Perc(filename, window_lenth(opcional), salto(opcional), harm_filter_order(opcional), perc_filter_order(opcional))
% Separa la parte armonica de la percusiva
%
% filename:                         Nombre del archivo .wav a analizar
% window_lenth(opcional) = 1024:    Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
% salto(opcional) = 128:            Cuanto mas chico el salto, achica el ancho de los pulsos, pero demora mas
% harm_filter_order(opcional) = 17: Orden del filtro de mediana para la parte armonica
% perc_filter_order(opcional) = 17: Orden del filtro de mediana para la parte percusiva
%
% DAFx_Harm:    Parte armonica
% DAFx_Perc:    Parte percusiva
% fs:           Frecuencia de muestreo

    if ~exist('window_lenth', 'var')
        window_lenth = 1024;    % Cuanto mas grande la ventana, mas diferencia la parte percusiva de la armonica, pero demora mas
    end
    if ~exist('salto', 'var')
        salto = 128;            % Cuanto mas chico el salto, achica el ancho de los pulsos, pero demora mas
    end
    if ~exist('harm_filter_order', 'var')
        harm_filter_order = 17; % Orden del filtro de mediana para la parte armonica
    end
    if ~exist('perc_filter_order', 'var')
        perc_filter_order = 17; % Orden del filtro de mediana para la parte percusiva
    end

    p = 1;
    window_1 = hanning(window_lenth,'periodic');
    window_2 = window_1;
    bloque_del_medio = floor(harm_filter_order/2)+1;    % NOTA: Este bloque_del_medio es el "bloque actual" desde el punto de vista del filtro de mediana


        %----- inicializaciones -----%
    [DAFx_in, fs] = wavread(filename);                  % Cargo audio
    DAFx_in = DAFx_in(:,1);                             % Tomo un solo canal
    DAFx_in = [zeros(window_lenth, 1); DAFx_in];        % Agrego zeros del tamaño de la ventana al comienzo del vector de entrada
    DAFx_in = Complete_vector(DAFx_in', window_lenth)'; % Completo con tantos ceros al final del vector de entrada tal que su longitud sea divisible por el tamaño de la ventana
    DAFx_in = DAFx_in / max(abs(DAFx_in));
    DAFx_Perc = zeros(length(DAFx_in),1);               % Creo un vector para la percucion del tamaño actual de la entrada
    DAFx_Harm = zeros(length(DAFx_in),1);               % Creo un vector para la armonia del tamaño actual de la entrada

        % Inicializo buffers que voy a utilizar
    buffer_abs = zeros(window_lenth,harm_filter_order);
    buffer_complex = zeros(window_lenth,harm_filter_order);

    pin = 0;
    pout = 0;
    pend = length(DAFx_in)-window_lenth;


        %----- Comienza el algoritmo -----%
    tic

    %bloque: Tomo un bloque de la entrada del tamaño de la ventana y aplico ventaneo

    while pin < pend
        bloque = DAFx_in(pin+1:pin+window_lenth).* window_1; 
        %===========================================
        fft_bloque = fft(bloque);           % FFT del bloque que tomo
        abs_fft_bloque = abs(fft_bloque);   % Modulo de la FFT del bloque

        % En buffercomplex guardo los ultimos 'harm_filter_len' bloques de la
        % FFT del bloque (borro las FFT mas viejas)
        buffer_complex(:,1:harm_filter_order-1)=buffer_complex(:,2:end);
        buffer_complex(:,harm_filter_order)=fft_bloque;

        % En bufer guardo los ultimos 'harm_filter_len' bloques del modulo de
        % la FFT del bloque (borro los modulos de FFT mas viejas)
        buffer_abs(:,1:harm_filter_order-1) = buffer_abs(:,2:end);
        buffer_abs(:,harm_filter_order) = abs_fft_bloque;

        % El median-filter es """"""Como un pasa bajos"""""" (entre muchas comillas)
        % Aplico median-filter al modulo de FFT del "bloque actual" del buffer
        % (eso realza la parte percusiva)
        Per = medfilt1(buffer_abs(:,bloque_del_medio),perc_filter_order);
        % Aplico mediana al modulo de FFT de varios bloques anteriores a
        % travez de cada bin de frecuencia (eso realza la parte armonica)
        Har = median(buffer_abs,2);

        % Usa la parte percusiva y armonica halladas anteriormente y genera
        % mascaras
        if(Har == 0)
            maskHar = 0;
        else
            maskHar = (Har.^p)./(Har.^p + Per.^p);
        end

        if(Har == 0)
            maskPer = 0;
        else
            maskPer = (Per.^p)./(Har.^p + Per.^p);
        end

        % Aplica las mascaras al "bloque actual" del buffer
        % Utiliza la FFT compleja porque despues invierte la FFT para volver a
        % tiempo.
        curframe = buffer_complex(:,bloque_del_medio);
        perframe = curframe.*maskPer;
        harframe = curframe.*maskHar;
        grain1 = real(ifft(perframe)).*window_2;
        grain2 = real(ifft(harframe)).*window_2;

        %===========================================
        DAFx_Perc(pout+1:pout+window_lenth) = DAFx_Perc(pout+1:pout+window_lenth) + grain1;
        DAFx_Harm(pout+1:pout+window_lenth) = DAFx_Harm(pout+1:pout+window_lenth) + grain2;
        pin = pin + salto;
        pout = pout + salto;
    end
    toc
        %----- Termina el algoritmo -----%

    %----- listening and saving the output -----
    DAFx_Perc = DAFx_Perc((window_lenth + salto*(bloque_del_medio-1)):length(DAFx_Perc))/max(abs(DAFx_Perc));
    DAFx_Harm = DAFx_Harm(window_lenth + (salto*(bloque_del_medio-1)):length(DAFx_Harm))/max(abs(DAFx_Harm));
    % soundsc(DAFx_out1, FS);
    % soundsc(DAFx_out2, FS);
    wavwrite(DAFx_Perc, fs, 'ex-percussion_2.wav');
    wavwrite(DAFx_Harm, fs, 'ex-harmonic_2.wav');

    % Envolvente = medfilt1(medfilt1(abs(DAFx_Perc), 128),128);

    %{
    figure(2);
    b(1) = subplot(311);
    plot(DAFx_in_orig);
    b(2) = subplot(312);
    plot(Envolvente, 'r');    % Median-filter de la parte absoluta de la percucion, es como """"""la envolvente"""""" (Doble median-filter para mejor resultado. Es mejor hacer un duble median-filter de orden bajo que un median-filter de orden alto, pero requiere mayor tiempo computacional)
    b(3) = subplot(313);
    plot(DAFx_Harm);

    linkaxes(b,'x');
    %}

