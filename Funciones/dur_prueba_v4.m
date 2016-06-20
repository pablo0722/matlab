function [nota] = dur_prueba_v4(in, i_b, i_m, w_len, fs, ploteo)
% dur_prueba_v4 devuelde un numero que determina si en el bloque 'i_b' de
% 'in' comienza una nota nueva, se mantuvo la anterior, o es silencio.
%
% [nota] = dur_prueba_v4(in, i_b, i_m, w_len, fs, ploteo)
% in:       Signal de entrada
% i_b:      Numero de bloque de la señal de entrada a analizar
% i_m:      Cantidad de muestras de corrimiento
% w_len:    largo del bloque
% fs:       Frecuencia de muestreo de la signal de entrada
% ploteo:   1: hace ploteos - 2: NO hace ploteos
% [nota]:   2: Empieza nota nueva - 1: Se mantiene la nota anterior - 0: Silencio
%
% For more information, see <a href="https://sourceforge.net/p/dplabaudio/wiki/Home/">Wiki del DPLab-Audio</a>.
%
% See also max_fft, max_relativos_fft, max_relativos, max_max_fft, mayores, plotFFT, tono, tono_con_armonicos.
%
% Version 4.0 01-10-2015

    persistent window;
    persistent bloque_ant;
    persistent ruido;       % nivel de ruido
    persistent ruido_2;     % nivel de (ruido.^2)
    persistent flag_nota;   % Flag de cuando arranca y termina una nota
    persistent first;
    
    if length(window) ~= w_len
    	window = hanning(w_len,'periodic');
        bloque_ruido = in( 1 : w_len );
        bloque_ruido = bloque_ruido .* window;
        [~, fft_y] = fft_abs(bloque_ruido,w_len,fs);
        ruido = sum(fft_y(2:end));
        ruido_2 = sum(fft_y(2:end).^2);
        flag_nota = 0;
    end
    
    bloque = in( (w_len*i_b)+1+i_m : w_len*(i_b+1)+i_m);
    bloque = bloque .* window;
    
    if length(bloque_ant) ~= length(bloque)
        bloque_ant = bloque;
    end
    
    piso_ruido = 128;
    nivel_param = 0.5;
    vista = 50;
    
    
    [~, fft_y1] = fft_abs(bloque_ant,length(bloque_ant),fs);
    [~, fft_y2] = fft_abs(bloque,length(bloque),fs);
    

    fft_anterior = fft_y1(2:end).^2;
    fft_actual = fft_y2(2:end).^2;
    
    %{
    diff_fft = (fft_actual-fft_anterior) / (sum(fft_anterior) + sum(fft_actual));
    abs_diff_fft = abs(diff_fft);

    sum_diff_fft = sum(diff_fft);                   % Parametro 1
    sum_abs_diff_fft = sum(abs_diff_fft);           % Parametro 2
    div_param = sum_diff_fft/sum_abs_diff_fft;      % Parametro 1 / Parametro 2
    suma_param = sum_diff_fft + sum_abs_diff_fft;   % Parametro 1 + Parametro 2
    %}

    Param_A = sum(abs(fft_actual - fft_anterior));
    Param_B = sum(fft_actual - fft_anterior);
    Param_C = sum(fft_actual + fft_anterior);
    
    %Param_numerador = (Param_A^2);
    %Param_Denominador = ((Param_A^2)-(Param_A*Param_B)+(Param_A*Param_C));
    
    Param_total = (Param_A*sign(Param_B))/Param_C;
    %Param_total = (Param_A^2)/((Param_A^2)-(Param_A*Param_B)+(Param_A*Param_C));
    
    if ploteo
        
            % Si la potencia es suficientemente mayor a un piso de ruido, entonces:
        %if (sum(fft_anterior) > piso_ruido*(ruido_2)) || (sum(fft_actual) > piso_ruido*(ruido_2))
        if (sum(fft_actual) > piso_ruido*ruido_2)
                % Para notas fuertes:
                % si la suma de los parametros es mayor a un cierto nivel,
                % Empieza la nota
            %if ((sum(fft_anterior) > ruido) || (sum(fft_actual) > ruido)) && ( Param_total > nivel_param )
            if ( Param_total > nivel_param )
                nota_disp = 'EMPIEZA NOTA';
                
                % Para notas suaves:
                % solo analizo los dos ultimos parametros (division y suma)
            %elseif (sum(fft_anterior) < ruido) && (sum(fft_actual) < ruido) && (div_param > piso_div_2) && (suma_param > piso_suma_2)
            %    disp('EMPIEZA NOTA');
            %    disp(' ');
        
                % Si no comienza una nota pero la potencia sigue siendo
                % alta, entonces sigue la misma nota
            elseif  (flag_nota > 0)
                nota_disp = 'SIGUE NOTA';
            else
                nota_disp = 'SILENCIO fuerte';
            end
            % Si la potencia NO es muy alta, es silencio:
        else
            nota_disp = 'SILENCIO debil';
        end
        %{
        disp(nota_disp);
        disp(' ');
        
    
        disp(['Param_A: ' num2str(Param_A) '; Param_B: ' num2str(Param_B) '; Param_C: ' num2str(Param_C) '; Param_total: ' num2str(Param_total)]);
        disp(['nivel: ' num2str(sum(fft_actual)) '; piso: ' num2str(piso_ruido*ruido_2)]);
        %}
        
        Archivo_excel = 'myExample.xlsx';
        headers = {'Param_A', 'Param_B', 'Param_C', 'Nota'};
        values = {[Param_A], [Param_B], [Param_C], nota_disp};
        
        if Param_C < Param_B || Param_C < Param_A
            disp('ERROR');
        end
        
        if ~isempty(first)
            [dump1 dump2 raw] = xlsread(Archivo_excel, 'nuevo');
            xlswrite(Archivo_excel,[raw; values], 'nuevo');
        else
            first = 1;
            xlswrite(Archivo_excel,[headers; values], 'nuevo');
        end
        
        %{
        disp(['P(x1) = ' num2str(sum(fft_anterior))]);
        disp(['P(x2) = ' num2str(sum(fft_actual))]);
        disp(['P(x3) = ' num2str(sum_diff_fft)]);
        disp(['P(x4) = ' num2str(sum_abs_diff_fft)]);
        disp(['/: = ' num2str(div_param)]);
        disp(['-: = ' num2str(suma_param)]);
        disp(['ruido: = ' num2str(ruido)]);
        disp(['ruido_2: = ' num2str(ruido_2)]);
        %}
        
        %{
        ax1 = subplot(211);
            plot(in);
            hold on;
            plot((w_len*i_b)+1+i_m : w_len*(i_b+1)+i_m, bloque, 'r');
            hold off;
            axis(ax1, [(w_len*(i_b-vista))+1+i_m w_len*(i_b+1+vista)+i_m -1 1]);    % limites de los ejes
        
        ax2 = subplot(212);
            plot(bloque);
        %}
        %{
        ax3 = subplot(313);
            plot(fft_x, abs_diff_fft);
            axis(ax3, [0 4000 0 1]);    % limites de los ejes
        %}
            
        %linkaxes([ax1 ax2], ['x' 'y']);     % Linkea ejes
        %axis([ax1 ax2 ax3], [0 4000 -2 2]);    % limites de los ejes

        %sound(bloque, fs);
        
    end

    bloque_ant = bloque;
    
    % Si la potencia es suficientemente mayor a un piso de ruido, entonces:
    %if (sum(fft_anterior) > piso_ruido*(ruido_2)) || (sum(fft_actual) > piso_ruido*(ruido_2))
    if (sum(fft_actual) > piso_ruido*ruido_2)
        % Para notas fuertes:
        % si la suma de los parametros es mayor a un cierto nivel,
        % Empieza la nota
        %if ((sum(fft_anterior) > ruido) || (sum(fft_actual) > ruido)) && ( Param_total > nivel_param )
        if ( Param_total > nivel_param )
            nota = 2;
            flag_nota = 2;

        % Para notas suaves:
        % solo analizo los dos ultimos parametros (division y suma)
        %elseif (sum(fft_anterior) < ruido) && (sum(fft_actual) < ruido) && (div_param > piso_div_2) && (suma_param > piso_suma_2)
        %    nota = 2;
        %    flag_nota = 2;

        % Si no comienza una nota pero la potencia sigue siendo
        % alta, entonces sigue la misma nota
        elseif  (flag_nota > 0)
            nota = 1;
            flag_nota = 1;
        else
            nota = 0;
            flag_nota = 0;
        end
        % Si la potencia NO es muy alta, es silencio:
    else
        nota = 0;
        flag_nota = 0;
    end
        
end







