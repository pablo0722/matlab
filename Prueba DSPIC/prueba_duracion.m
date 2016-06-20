clc;
clear all;
close all;


%restoredefaultpath;

[in, fs] = wavread('D:\UTN\Matlab\Audios\otras\jijiji.wav');
in = in(:,1);
len = 1024;

for i=0:floor(length(in)/len - 1)

    [nota] = dur_prueba_v4(in, i, 0, len, fs, 0);
    disp(['bloque ' num2str(i) ': ' num2str(nota)]);

end

num_bloque = [0 1 2 3 4 37 38 39 40 41 42 43];

for i = 1:length(num_bloque)
    [~, fft_y] = get_bloque_fft(in, num_bloque, len*5, fs);
    Signal2MCH(['./bloque_' num2str(num_bloque(i)) '.mch'], fft_y);
end;