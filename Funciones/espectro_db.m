function espectro_db(s, N)

    N = (N+512);
    % normalizacion entre 0 y 2pi
    eje_norm = 0:N-1;
    eje_norm = eje_norm * 2 * pi / N;
    
    % Transformada
    transformada = fft(s, N)/N;
    tdb = 2 * mag2db(abs(transformada));
    plot(eje_norm(1:length(tdb)/2+1), tdb(1:end/2+1));

end