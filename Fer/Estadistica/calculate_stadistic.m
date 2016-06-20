function calculate_stadistic(in, len, fs)

    media = mean(in);
    varianza = var(in);
    curtosis = kurtosis(in);
    disp(['media: ' num2str(media) ' - varianza: ' num2str(varianza) ' - curtosis: ' num2str(curtosis)]);

    figure;
    plot(in, 'k'); hold on;
    plot(media*ones(1,len), 'r');
    plot(varianza*ones(1,len), 'g');
    plot(curtosis*ones(1,len), 'b');
    legend('', 'media', 'varianza', 'curtosis');


    [~, in ] = fft_abs(in, len, fs);
    len = length(in);
    media = mean(in);
    varianza = var(in);
    curtosis = kurtosis(in);
    disp(['media: ' num2str(media) ' - varianza: ' num2str(varianza) ' - curtosis: ' num2str(curtosis)]);

    figure;
    plot(in, 'k'); hold on;
    plot(media*ones(1,len), 'r');
    plot(varianza*ones(1,len), 'g');
    plot(curtosis*ones(1,len), 'b');
    legend('', 'media', 'varianza', 'curtosis');

end