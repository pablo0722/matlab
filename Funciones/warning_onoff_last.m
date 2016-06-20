function warning_onoff_last(on_off)
%% warning_onoff_last(on_off)
% Activa/Desactiva el ultimo warning
%
% on_off [in]:  'on' o 'off'. Si no se especifica, activa todos los warnings.

%%
    if ~exist('on_off', 'var')
        on_off = 'none';
    end
    
    if strcmp(on_off, 'on') || strcmp(on_off, 'off')
        w = warning('query','last');
        id = w.identifier;
        warning(on_off,id);
        
        display(' ');

        if strcmp(on_off, 'on')
            display('Se ha activado el siguiente warning');
        elseif strcmp(on_off, 'off')
            display('Se ha desactivado el siguiente warning');
        end
        
        display(w.identifier);
        w = warning('query','last');
        display(w);
    else
        warning ('on','all');
        display('Se han activado todos los warnings');
    end
end