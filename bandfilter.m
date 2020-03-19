function [filtered] = bandfilter(N, x, fs, band)
    filtered = zeros(size(x))
    for i = 1:N
        filtered(:,i) = bandpass(x(:,i),band,fs)
    end
end