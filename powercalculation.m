function [power,filtered] = powercalculation (N, fs, band, x)
    filtered = zeros(size(x))
    power = zeros(N,1)
    length = size(x,1)
    for i = 1:N
        signal = x(:,i)
        filtered_signal = bandpass(signal,band,fs)
        power(i) = sum(abs(filtered_signal).^2)
        filtered(:,i) = abs(filtered_signal).^2
    end
    power(i) = power(i)/length
end