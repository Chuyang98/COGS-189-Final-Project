function BetaWaveAnalysis()
    %% Load the data
    load("Subject1_2D.mat")
    
    
    %% Create Topoplots
    loc = readlocs('standard-10-5-cap385.elp');
    
    % Extract desired channels:
    % FP1 FP2 F3 F4 C3 C4 P3 P4 O1 O2 F7 F8 T3 T4 T5 T6 FZ CZ PZ
    desiredChans = {'Fp1', 'Fp2', 'F3', 'F4', 'C3', 'C4', 'P3', 'P4', ...
                    'O1', 'O2', 'F7', 'F8', 'T3', 'T4', 'T5', 'T6',   ...
                    'Fz', 'Cz', 'Pz'};
                
    % Iterate through labels and determine which indices match up
    selected = [];
    for i = 1:length(loc)
        if sum(contains(desiredChans, loc(i).labels)) == 1
            selected = [selected i];
        end
    end
    selected_loc = loc(selected); % subset all locs
    
    %% calculate the power
    [Power_Left_For_Img,Filtered_Left_For_Img] = powercalculation (19, 500, [14,30], LeftForwardImagined);
    [Power_Left_Back_Img,Filtered_Left_Back_Img] = powercalculation (19, 500, [14,30], LeftBackwardImagined);
    [Power_Right_For_Img,Filtered_Right_For_Img] = powercalculation (19, 500, [14,30], RightForwardImagined);
    [Power_Right_Back_Img,Filtered_Right_Back_Img] = powercalculation (19, 500, [14,30], RightBackwardImagined);
    %% Product Plots
    figure(1)
    subplot(2,2,1)
    topoplot(Power_Left_For_Img, selected_loc);
    title("Imagined Left Hand Moving Forward")
    subplot(2,2,2)
    topoplot(Power_Right_For_Img, selected_loc);
    title("Imagined Right Hand Moving Forward")
    subplot(2,2,3)
    topoplot(Power_Left_Back_Img, selected_loc);
    title("Imagined Left Hand Moving Backward")
    subplot(2,2,4)
    topoplot(Power_Right_Back_Img, selected_loc);
    title("Imagined Right Hand Moving Backward")
    
    
    %% Select train data from each filtered dataset
    
    [left_for_img_train, left_for_img_test] = split_train_and_test(Filtered_Left_For_Img, 5);
    [left_back_img_train, left_back_img_test] = split_train_and_test(Filtered_Left_Back_Img, 5);
    [right_for_img_train, right_for_img_test] = split_train_and_test(Filtered_Right_For_Img, 5);
    [right_back_img_train, right_back_img_test] = split_train_and_test(Filtered_Right_Back_Img, 5);
    
    %% LDA - Conventional
    right_left_for_img_LDA = LDA_train(left_for_img_train, right_for_img_train);
    [right_left_for_img_LDA_accuracy,right_left_for_img_LDA_approx,right_left_for_img_LDA_test] = accuracy_test(left_for_img_test, right_for_img_test, right_left_for_img_LDA);
    right_left_back_img_LDA = LDA_train(left_back_img_train, right_back_img_train);
    [right_left_back_img_LDA_accuracy,right_left_back_img_LDA_approx,right_left_back_img_LDA_test] = accuracy_test(left_back_img_test, right_back_img_test, right_left_back_img_LDA);
    
    %% SVM - Conventional
    right_left_for_img_SVM = SVM_train(left_for_img_train, right_for_img_train);
    [right_left_for_img_SVM_accuracy,right_left_for_img_SVM_approx,right_left_for_img_SVM_test] = accuracy_test(left_for_img_test, right_for_img_test, right_left_for_img_SVM);
    right_left_back_img_SVM = SVM_train(left_back_img_train, right_back_img_train);
    [right_left_back_img_SVM_accuracy,right_left_back_img_SVM_approx,right_left_back_img_SVM_test] = accuracy_test(left_back_img_test, right_back_img_test, right_left_back_img_SVM);
    
    % Right vs Left Imagery, new classifiers
    %% select new train data and test data
    % we will select the position FP2, C3, CZ, C4, P3, PZ, P4, O1, O2
    new_left_for_img_train = left_for_img_train(:,[2,5,6,7,8,9,10,18,19]);
    new_left_back_img_train = left_back_img_train(:,[2,5,6,7,8,9,10,18,19]);
    new_right_for_img_train = right_for_img_train(:,[2,5,6,7,8,9,10,18,19]);
    new_right_back_img_train = right_back_img_train(:,[2,5,6,7,8,9,10,18,19]);
    
    new_left_for_img_test = left_for_img_test(:,[2,5,6,7,8,9,10,18,19]);
    new_left_back_img_test = left_back_img_test(:,[2,5,6,7,8,9,10,18,19]);
    new_right_for_img_test = right_for_img_test(:,[2,5,6,7,8,9,10,18,19]);
    new_right_back_img_test = right_back_img_test(:,[2,5,6,7,8,9,10,18,19]);
    
    %% LDA - New
    new_right_left_for_img_LDA = LDA_train(new_left_for_img_train, new_right_for_img_train);
    [new_right_left_for_img_LDA_accuracy, new_right_left_for_img_LDA_approx,new_right_left_for_img_LDA_test] = accuracy_test(new_left_for_img_test, new_right_for_img_test, new_right_left_for_img_LDA);
    new_right_left_back_img_LDA = LDA_train(new_left_back_img_train, new_right_back_img_train);
    [new_right_left_back_img_LDA_accuracy,new_right_left_back_img_LDA_approx,new_right_left_back_img_LDA_test] = accuracy_test(new_left_back_img_test, new_right_back_img_test, new_right_left_back_img_LDA);
    
    %% SVM - New
    new_right_left_for_img_SVM = SVM_train(new_left_for_img_train, new_right_for_img_train);
    [new_right_left_for_img_SVM_accuracy, new_right_left_for_img_SVM_approx,new_right_left_for_img_SVM_test] = accuracy_test(new_left_for_img_test, new_right_for_img_test, new_right_left_for_img_SVM);
    new_right_left_back_img_SVM = SVM_train(new_left_back_img_train, new_right_back_img_train);
    [new_right_left_back_img_SVM_accuracy,new_right_left_back_img_SVM_approx,new_right_left_back_img_SVM_test] = accuracy_test(new_left_back_img_test, new_right_back_img_test, new_right_left_back_img_SVM);
    
    %% Conclusion
    
    all_right_left_img = [right_left_for_img_LDA_accuracy, ...
        new_right_left_for_img_LDA_accuracy; 
        right_left_back_img_LDA_accuracy,...
        new_right_left_back_img_LDA_accuracy;
        right_left_for_img_SVM_accuracy,...
        new_right_left_for_img_SVM_accuracy;
        right_left_back_img_SVM_accuracy,...
        new_right_left_back_img_SVM_accuracy
        ];

    figure(2)
    hB = bar(all_right_left_img)
    str={'LDA - Forward';'LDA - Backward'; ...
        'SVM - Forward'; "SVM  - Backward"};
    hAx=gca;
    hAx.XTickLabel=str;
    hT=[];
    for i=1:length(hB)  % iterate over number of bar objects
        hT=[hT text(hB(i).XData+hB(i).XOffset,hB(i).YData,num2str(hB(i).YData.','%.3f'), ...
            'VerticalAlignment','bottom','horizontalalign','center')];
    end
    l{1}='Conventional'; 
    l{2}='New Protocal';
    legend(hB,l)
    
    %% Confusion Matrix - Conventional LDA
    figure(3)
    plotconfusion(right_left_for_img_LDA_test',right_left_for_img_LDA_approx', "LDA - Forward Movement")
    figure(4)
    plotconfusion(right_left_back_img_LDA_test',right_left_back_img_LDA_approx',"LDA - Backward Movement")
    %% Confusion Matrix - Conventional SVM
    figure(5)
    plotconfusion(right_left_for_img_SVM_test',right_left_for_img_SVM_approx', "SVM - Forward Movement")
    figure(6)
    plotconfusion(right_left_back_img_SVM_test',right_left_back_img_SVM_approx',"SVM - Backward Movement")
    
    %% Confusion Matrix - New LDA
    figure(7)
    plotconfusion(new_right_left_for_img_LDA_test',new_right_left_for_img_LDA_approx', "LDA - Forward Movement - New")
    figure(8)
    plotconfusion(new_right_left_back_img_LDA_test',new_right_left_back_img_LDA_approx',"LDA - Backward Movement - New")
    %% Confusion Matrix - New SVM
    figure(9)
    plotconfusion(new_right_left_for_img_SVM_test',new_right_left_for_img_SVM_approx', "SVM - Forward Movement - New")
    figure(10)
    plotconfusion(new_right_left_back_img_SVM_test',new_right_left_back_img_SVM_approx',"SVM - Backward Movement - New")
    
    