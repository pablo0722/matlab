clear all
close all


filename = 'jijiji.wav';
N = 1024;
num_bloque = 1;

[signal, Fs] = wavread(filename);


bloque = signal( num_bloque*N+1 : num_bloque*(N+1) );