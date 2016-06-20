% ----------------------------------------------------------------------------------------------
% Funcion Signal to file MCH
% 
% Ultima modificación: 11/2013
% 
% Autor: Ing.César Angel Fuoco
%
% Descripción:
% Funcion que guarda un vector de 1xN muestras en un archivo de texto. Cada elemento se expresa 
% en hex signed de 16bits y la forma de la tabla es una matriz de N/8 filas x 8 Columnas
%
% ----------------------------------------------------------------------------------------------

function Signal2MCH(file_name,senal)

    senal=fi(senal,1,16,15); 					% recibe en double y guardar en punto fijo 
    
    N= length(senal);

    str=[];
    
    for i=1: N
        str =[str ; hex(senal(i))];
    end

  
    fid = fopen(file_name,'wt');            			 % creo el archivo

    for i=1: (N/8)
        for k=1:8
            fprintf(fid,'%s\t',str( (i-1)*8 + k,:) );     	% escribo los elementos de las columnas
        end
        fprintf(fid,'\n');                   			% escribo un enter
    end

    fclose(fid);                      

    return ;
end
