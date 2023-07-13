%% choose path for results (dummy or not)
falseKeyZeroWeight = calcRowAVG("ibex_6k_runs/ibex_master_3_results/falseKeyZeroWeight");
falseKeyOneWeight = calcRowAVG("ibex_6k_runs/ibex_master_3_results/falseKeyOneWeight");
trueKeyZeroWeight = calcRowAVG("ibex_6k_runs/ibex_master_3_results/trueKeyZeroWeight");
trueKeyOneWeight = calcRowAVG("ibex_6k_runs/ibex_master_3_results/trueKeyOneWeight");


%%
AES_last = 71210;
falseKeyOneWeight = falseKeyOneWeight(1:AES_last);
falseKeyZeroWeight = falseKeyZeroWeight(1:AES_last);
trueKeyOneWeight = trueKeyOneWeight(1:AES_last);
trueKeyZeroWeight = trueKeyZeroWeight(1:AES_last);
%%
res = trueKeyOneWeight - trueKeyZeroWeight;
res2 = falseKeyOneWeight - falseKeyZeroWeight;
trueKeyMaxDiff = max(res);
trueKeyMinDiff = min(res);
falseKeyMaxDiff = max(res2);
falseKeyMinDiff = min(res2);
res(1:11156) = 0;
res2(1:11156) = 0;
%% plot (true for dummy enabled, false for disabled)
plotter(res,res2);



%%
function plotter(res,res2)
    figure();
    plot(res,'LineWidth',1.5);
    title("True Key",'FontSize',15);
    hold on;
    xlabel("cycle",'FontSize',15);
    ylabel("diff",'FontSize',15);
    grid("on"); 
    figure()
    plot(res2,'LineWidth',1.5);
    title("False Key",'FontSize',15);
    hold on;
    xlabel("cycle",'FontSize',15);
    ylabel("diff",'FontSize',15);
    grid("on");
end
%%
function rowAVG = calcRowAVG(directory)    
    fileList = dir(directory);
    % Determine the number of files (n)
    n = numel(fileList);
    
    % Initialize a cell array to store the data from each file
    data = cell(n-2, 1);
    
    % Read data from each file into the cell array
    for i = 3:n
        filename = fullfile(directory, fileList(i).name);
        fileID = fopen(filename, 'r');
        data{i-2} = fscanf(fileID, '%d');
        fclose(fileID);
    end
    
    % Determine the maximum number of rows among the files
    maxRows = max(cellfun(@numel, data));
    
    % Pad the shorter rows with zeros to make them of equal length
    for i = 3:n
        numRows = numel(data{i-2});
        if numRows < maxRows
            data{i-2}(numRows+1:maxRows) = 0;
        end
    end
    
    rowAVG = zeros(maxRows, 1);
    
    % Compute the sum of each row across the files
    for current_row = 1:maxRows
        for current_file = 1:n-2
           rowAVG(current_row) = rowAVG(current_row) + data{current_file}(current_row);
        end
        rowAVG(current_row) = rowAVG(current_row)/(n-2);
    end
    % Display the row sums
end


