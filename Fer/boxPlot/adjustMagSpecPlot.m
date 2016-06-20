function [] = adjustMagSpecPlot(header,ymin,ymax,fontSize,fScale,mScale)
%ADJUSTMAGSPECPLOT 
%   Ajusta las graficas del espectro de magnitud de una senal.
%       header:   si se pasa 'psd' como parametro el titulo se ajusta para 
%                 mostrar PSD, sino se ajusta para ESPECTRO DE MAGNITUD
%       ymin:     permite ajustar el limite inferior del eje vertical
%       ymax:     permite ajustar el limite superior del eje vertical
%                 Si ymin == ymax => AXIS TIGHT
%       fontSize: ajusta el tamaño de las letras
%       fScale:   si se pasa 'norm' como parametro el eje X se ajusta
%                 para mostrar frec. normalizada, sino frec en Hz.
%       mScale:   si se pasa 'db' como parametro el eje Y se ajusta para 
%                 mostrar DB, sino se ajusta para mostrar MAGNITUD
%
%   Tanto el título como las etiquetas de los ejes están configuradas por
%   defecto. NO PUEDE MODIFICARSE
%
%   See also adjustPhaseSpecPlot adjustTimePlot maximizePlot
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
    
    if (strcmp(header,'psd'))
        title('Power Spectrum Density');
        ylabel('Magnitude [ $$\frac{A^2}{Hz}$$ ]','interpreter','latex');
    else
        title('Magnitude Spectrum');
        ylabel('Magnitude [ $$\frac{A}{\sqrt Hz}$$ ]','interpreter','latex');
    end;
    
    if (strcmp(fScale,'norm'))
        xlabel('Normalized Frequency [ $$\pi \cdot rad/sample$$ ]','interpreter','latex');
    else
        xlabel('Frequency [ Hz ]');
    end;
    
    if (strcmp(mScale,'db'))
        ylabel('Magnitude [dB]');
    end;
end