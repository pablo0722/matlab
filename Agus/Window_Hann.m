function [ Y ] = Window_Hann( x )
% Ventana Hann

% x: Se�al de entrada
% W: Ventana calculada
% Y: Se�al de salida

N = length(x);
W = zeros(1,N);

for i = 1:N
    W(i) = 0.5*(1-cos((2*pi*i)/(N-1)));
end
    Y = x .* W;
end

