function calculate_resta(in, len, fs)


%% TIEMPO
out = zeros(1,len);

out(1) = in(1);
for i=2:len
    out(i) = in(i) - in(i-1);
end

figure(1);
plot(in, 'b');
hold on;
plot(out, 'r');
legend('in', 'out');
hold off;

%% ESPECTRO

[~, in] = fft_abs(in, len, fs);
len = length(in);

out = zeros(1,len);

out(1) = in(1);
for i=2:len
    out(i) = in(i) - in(i-1);
end
out_2 = abs(out);

figure(2);
stem(in, 'b');
hold on;
stem(out, 'r');
stem(out_2, 'g');
plot((max(in)-max(out_2))*ones(1,len), 'k');
xlim([0 len/4]);
legend('in', 'out', 'out_2', 'max(out_2)');
hold off;


end