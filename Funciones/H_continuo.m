function H_continuo(num, den)
% Ej: H_continuo([1 0 1], [2 1 1]);

    bode(tf(num,den));

end