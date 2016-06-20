function [ Y ] = Window_Flat_Top( x )
% Ventana Flat Top

% x: Señal de entrada
% W: Ventana calculada
% Y: Señal de salida

a0 = 1;
a1 = 1.93;
a2 = 1.29;
a3 = 0.388;
a4 = 0.032;

N = length(x);
W = zeros(1,N);

for n = 1:N
    W(n) = a0 - a1 * cos((2*pi*n)/(N-1)) + a2 * cos((4*pi*n)/(N-1)); 
    W(n) = W(n) - a3 * cos((6*pi*n)/(N-1)) + a4 * cos((8*pi*n)/(N-1));
end
    Y = (x .* W)./5;
end

