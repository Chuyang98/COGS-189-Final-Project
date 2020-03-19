function [LDA] = LDA_train(train_set1, train_set2)
    length1 = size(train_set1,1)
    length2 = size(train_set2,1)
    X = [train_set1; train_set2]
    Y = zeros(length1+length2,1)
    Y(1:length1,1) = 1
    Y((length1+1):(length1+length2),1) = 0
    LDA = fitcdiscr(X,Y)
end
    
    
    