function [] = adjustTimePlot(ymin, ymax, fontSize, titulo, label_x, label_y)
%ADJUSTTIMEPLOT 
%   Ajusta las graficas para se�ales temporales
%       ymin: permite ajustar el limite inferior del eje vertical
%       ymax: permite ajustar el limite superior del eje vertical
%       fontSize: ajusta el tamano de las letras
%
%   Tanto el titulo como las etiquetas de los ejes estan configuradas por
%   defecto. NO PUEDE MODIFICARSE.
%
%   See also adjustMagSpecPlot adjustPhasePlot maximizePlot
%
%   Autor: Orge Fernando Gabriel
%   Revision: 3
%   Fecha: 11/04/2016

    if ~exist('titulo', 'var')
        titulo = 'Representacion temporal';
    end

    if ~exist('label_x', 'var')
        label_x = 'Tiempo discreto';
    end

    if ~exist('label_y', 'var')
        label_y = 'Amplitud';
    end
    

    axis tight;
    if (ymin ~= ymax) 
        ylim([ymin ymax]);
    end;
    grid;
    set(gca,'FontSize', fontSize);
    title(titulo);
    xlabel(label_x);
    ylabel(label_y);
end