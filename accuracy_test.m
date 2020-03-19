function [accuracy,approx,true_value] = accuracy_test(test_set1, test_set2, model)
    length1 = size(test_set1,1)
    length2 = size(test_set2,1)
    length = length1 + length2
    true_value = zeros(length,1)
    true_value(1:length1,1) = 1
    true_value((length1+1):length,1) = 0
    test_set = [test_set1; test_set2]
    approx = model.predict(test_set)
    correct = sum(approx == true_value)
    accuracy = correct/length
end