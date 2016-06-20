function [fft_x, fft_y] = get_bloque_fft(in, num_bloque, w_len, fs)

    bloque = in( (num_bloque*w_len)+1 : (num_bloque+1)*w_len );
    [fft_x, fft_y] = fft_abs(bloque, w_len, fs);

end