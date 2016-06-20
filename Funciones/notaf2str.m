function [str] = notaf2str(f_nota)
%% nota2str
% nota2str recibe la frecuencia de una nota partiendo y devuelve un string
% que dice el nombre de la nota, la octava y su frecuencia
%
%   f_nota:   (in) Frecuencia de la nota que se desea convertir
%   str:        (out) string de la nota recibida


    str = 'none';
    %% Compruebo argumentos
    if f_nota <= 0 
        error('[ERROR] funcion notaf2str: f_nota debe ser > 0')
    end

    
    %% Constantes
    P = nthroot(2,12);      % Relacion entre notas
    P0 = 13.75;    % Primer nota que detecta (DO_-1 = LA_-1 - 9)
    octava0 = -1;           % Numero de octava de la nota de comienzo P0
    N0 = 10;             % Numero de nota que representa la nota de
                        % comienzo P0
                        % (1 = DO, ... , 10 = LA, ... , 12 = SI)

    notas = char('DO', 'DO#', 'RE', 'RE#', 'MI', 'FA', 'FA#', 'SOL',...
        'SOL#', 'LA', 'LA#', 'SI');
        % Vector de notas de una octava ...(de DO a SI)

    
    %% Genero string de salida
    nota = round(log(f_nota/P0)/log(P));
    octava = octava0 + fix((nota+N0-1)/12);
    str = [notas(mod(nota+N0-1,12)+1, :) num2str(octava) ': ' num2str(P0 * P^(nota)) ' Hz'];

    
end