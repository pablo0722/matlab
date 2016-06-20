function [ ] = exportPlot( pathstr,filename,export )
%EXPORTPLOT 
%   pathstr  => Directorio donde se guardara la imagen
%   filename => Nombre de la imagen
%   export   => true: exporta || false: no exporta
%
%   See also maximizePlot
%
%   Autor: Orge Fernando Gabriel
%   Revision: 1
%   Fecha: 29/10/2015
    
    if (export == true)
        maximizePlot();
        file = [pathstr filename];
        print(file,'-depsc');
        close all;
    end

end

