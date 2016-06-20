function [str] = nota2str(idx_nota)
%% nota2str
% nota2str recibe un numero que representa el indice de la nota partiendo
% del LA de la octava -1 (13,75 Hz) y devuelve un string que dice el nombre
% de la nota, la octava y su frecuencia
%
%   idx_nota:   (in) Numero de indice desde LA_-1. (idx_nota >= 0)
%   str:        (out) string de la nota recibida


    %% Compruebo argumentos
    if idx_nota < 0 
        error('[ERROR] funcion nota2str: idx_nota debe ser >= 0')
    end

    
    %% Constantes
    P0 = 13.75;         % Nota de comienzo (LA_-1)
    octava0 = -1;       % Numero de octava de la nota de comienzo P0
    N0 = 10;             % Numero de nota que representa la nota de
                        % comienzo P0
                        % (1 = DO, ... , 10 = LA, ... , 12 = SI)
    P = nthroot(2,12);  % Relacion entre notas
    
    notas = char('DO', 'DO#', 'RE', 'RE#', 'MI', 'FA', 'FA#', 'SOL',...
        'SOL#', 'LA', 'LA#', 'SI');
        % Vector de notas de una octava ...(de DO a SI)

    
    %% Genero string de salida
    idx_nota = idx_nota + N0;
        % Sumo 9 porque la escala empieza en un LA, no en un DO
    octava = octava0 + fix((idx_nota-1)/12);
    nota = mod(idx_nota-1,12)+1;
    str = [notas(nota,:) num2str(octava) ': ' num2str(P0 * P^(idx_nota-N0)) ' Hz'];

    
end