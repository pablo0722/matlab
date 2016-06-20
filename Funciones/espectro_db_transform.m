function espectro_db_transform(transformada, N, Ts)

    N = (N+512);
    
    % normalizacion entre 0 y 2pi
    eje_norm = 0:N-1;
    eje_norm = eje_norm * 2 * pi / N;
    
    % Transformada
    tdb = 2 * mag2db(abs(transformada));
    plot((Ts:Ts:Ts*length(tdb)), tdb);

end