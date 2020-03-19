function [train, test] = split_train_and_test(signal, k)
    rng(189)
    bin_size = round(size(signal, 1)/k)
    n_sample = size(signal, 1)
    randIdx = randperm(n_sample)
    testIdx = randIdx(1:bin_size); 
    trainIdx = randIdx(bin_size+1:end);
    train = signal(trainIdx,:)
    test = signal(testIdx, :)
end