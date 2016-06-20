function [ Y ] = Window_Blackman_Harris( x )
% Ventana Blackman Harris

% x: Señal de entrada
% W: Ventana calculada
% Y: Señal de salida

N = length(x);
W = zeros(1,N);

a0 = 0.35875;
a1 = 0.48829;
a2 = 0.14128;
a3 = 0.01168;

for i = 1:N
    W(i) = a0 - a1 * cos((2*pi*i)/(N-1)) + a2 * cos((4*pi*i)/(N-1));
    W(i) = W(i) - a3 * cos((6*pi*i)/(N-1));
end
    Y = x .* W;
end

