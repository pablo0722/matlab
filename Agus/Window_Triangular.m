function [ Y ] = Window_Triangular( x )
% Ventana Triangular

% x: Señal de entrada
% W: Ventana calculada
% Y: Señal de salida

N = length(x);
W = zeros(1,N);

for i = 1:N
    W(i) = (2/(N+1)) * (((N+1)/2) - abs(i - ((N-1)/2)));
end
    Y = x .* W;
end

