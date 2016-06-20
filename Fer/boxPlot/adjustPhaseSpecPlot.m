function [] = adjustPhaseSpecPlot(ymin,ymax,fontSize)
%ADJUSTPHASESPECPLOT 
%   Ajusta las graficas del espectro de fase de una senal.
%       ymin:     permite ajustar el limite inferior del eje vertical
%       ymax:     permite ajustar el limite superior del eje vertical
%                 Si ymin == ymax => AXIS TIGHT
%       fontSize: ajusta el tamaño de las letras
%
%   Tanto el titulo como las etiquetas de los ejes estan configuradas por
%   defecto. NO PUEDE MODIFICARSE
%
%   See also adjustMagSpecPlot adjustTimePlot maximizePlot
%
%   Autor: Orge Fernando Gabriel
%   Revision: 3
%   Fecha: 11/04/2016

    axis tight;
    if (ymin ~= ymax) 
        ylim([ymin ymax]);
    end;
    grid;
    set(gca,'FontSize',fontSize);
    title('Phase Spectrum');
    xlabel('Frequency [ Hz ]');
    ylabel('Phase [ rad ]');
end