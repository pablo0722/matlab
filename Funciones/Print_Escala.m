function [out] = Print_Escala()
%% Print_Escala
% Imprime la escala en pantalla y guarda la frecuencia de las notas en una
% matriz de 12x9 (notas x Nº_de_octava)

%% Constantes
P = nthroot(2,12);      % Relacion entre notas
P0 = 13.75 * P^(-9);    % Primer nota que detecta (DO_-1 = LA_-1 - 9)

notas = char('DO', 'DO#', 'RE', 'RE#', 'MI', 'FA', 'FA#', 'SOL', ...
    'SOL#', 'LA', 'LA#', 'SI');
    % Vector de notas de una octava (de DO a SI)

%% Imprime octavas de la -1 a la 7
i = -1:7;
out = P0*P.^((0:1:11)')*P.^((12*(i+1))); % Calcula la frecuencia de cada nota

display(['NOTAS' ' ' ' OCTAVA_-1' '    ' ' OCTAVA_0' '    ' ' OCTAVA_1']);
display([notas ones(12,1)*'     ' num2str(out(:,1:3))]);

display(' ');

display(['NOTAS' '   ' ' OCTAVA_2' '     ' ' OCTAVA_3' '     ' ' OCTAVA_4']);
display([notas ones(12,1)*'     ' num2str(out(:,4:6))]);

display(' ');

display(['NOTAS' '   ' ' OCTAVA_5' '      ' ' OCTAVA_6' '      ' ' OCTAVA_7']);
display([notas ones(12,1)*'    ' num2str(out(:,7:9))]);


end