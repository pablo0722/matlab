function [ Y ] = Window_Hann( x )
% Ventana Hann

% x: Señal de entrada
% W: Ventana calculada
% Y: Señal de salida

N = length(x);
W = zeros(1,N);

for i = 1:N
    W(i) = 0.5*(1-cos((2*pi*i)/(N-1)));
end
    Y = x .* W;
end

