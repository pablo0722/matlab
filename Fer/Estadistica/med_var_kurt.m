clc;
clear all;
close all;

 
fs = 22050;
len = 1024;

varianza = 0.1;
media = 0;


[in, fs] = wavread('jijiji.wav');

%in = tono(440, fs, len) + randn(1, len)*varianza + media;

figure(3);
plot(in, 'b');
hold on;


%calculate_stadistic(in, len, fs);
for i=37:floor(length(in)/len)
    bloque = in(i*len+1 : (i+1)*len); 
    
    figure(3);
    plot(in, 'b');
    hold on;
    plot(i*len+1 : (i+1)*len, bloque, 'r');
    hold off;
    
    calculate_resta(bloque, len, fs);
    
    waitforbuttonpress;
end