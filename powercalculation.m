function [power,filtered] = powercalculation (N, fs, band, x)
    filtered = zeros(size(x))
    power = zeros(N,1)
    length = size(x,1)
    for i = 1:N
        signal = x(:,i)
        fftsignal = fft(signal)
        filtered_signal = bandpass(fftsignal,band,fs)
        power(i) = sum(abs(filtered_signal).^2)
        filtered(:,i) = abs(filtered_signal)
    end
    power(i) = power(i)/length
end