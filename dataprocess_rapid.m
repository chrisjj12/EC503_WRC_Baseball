clc;
clear all;
%load data files
data15 = readtable('Fangraphs Leaderboard15 (Rapid) .xlsx');
data16 = readtable('Fangraphs Leaderboard16 (Rapid) .xlsx');
data17 = readtable('Fangraphs Leaderboard17 (Rapid) .xlsx');
data18 = readtable('Fangraphs Leaderboard18 (Rapid) .xlsx');
data19 = readtable('Fangraphs Leaderboard19 (Rapid) .xlsx');
data20 = readtable('Fangraphs Leaderboard20 (Rapid) .xlsx');

%15-16 training data
data15_16 = [data15; data16];
%remove players from 2015 that arent in 2016/ 2015&2016 need equal order
cell2016 = table2cell(data16);
cell2015 = table2cell(data15);
[row, col] = size(data16);
organized_2016 = cell(row, col);
organized_2015 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data15.Name, data16.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2016(x, :) = cell2016(i, :);      %these two cells contain equal player order
        organized_2015(x, :) = cell2015(rowx, :);       % both contain the same players
        x = x + 1;
    end
    
end

X15 = organized_2015(:, [3:13 end]);
y15 = organized_2015(:, 14);
X16 = organized_2016(:, [3:13 end]);
y16 = organized_2016(:, 14);
X15_16 = cell2mat(X16) - cell2mat(X15);
y15_16 = cell2mat(y16) - cell2mat(y15);

%16-17 training data
data16_17 = [data16; data17];
%remove players from 2016 that arent in 2017/ 2016&2017 need equal order
cell2017 = table2cell(data17);
cell2016 = table2cell(data16);
[row, col] = size(data17);
organized_2017 = cell(row, col);
organized_2016 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data16.Name, data17.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2017(x, :) = cell2017(i, :);      %these two cells contain equal player order
        organized_2016(x, :) = cell2016(rowx, :);       % both contain the same players
        x = x + 1;
    end
    
end

X16 = organized_2016(:, [3:13 end]);
y16 = organized_2016(:, 14);
X17 = organized_2017(:, [3:13 end]);
y17 = organized_2017(:, 14);
X16_17 = cell2mat(X17) - cell2mat(X16);
y16_17 = cell2mat(y17) - cell2mat(y16);

%17-18 training data
data17_18 = [data17; data18];
%remove players from 2017 that arent in 2018/ 2017&2018 need equal order
cell2018 = table2cell(data18);
cell2017 = table2cell(data17);
[row, col] = size(data17);
organized_2018 = cell(row, col);
organized_2017 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data18.Name, data17.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2018(x, :) = cell2018(rowx, :);      %these two cells contain equal player order
        organized_2017(x, :) = cell2017(i, :);       % both contain the same players
        x = x + 1;
    end
    
end

X17 = organized_2017(:, [3:13 end]);
y17 = organized_2017(:, 14);
X18 = organized_2018(:, [3:13 end]);
y18 = organized_2018(:, 14);
X17_18 = cell2mat(X18) - cell2mat(X17);
y17_18 = cell2mat(y18) - cell2mat(y17);


%18-19 training data
data18_19 = [data18; data19];
%remove players from 2018 that arent in 2019/ 2018&2019 need equal order
cell2019 = table2cell(data19);
cell2018 = table2cell(data18);
[row, col] = size(data18);
organized_2019 = cell(row, col);
organized_2018 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data19.Name, data18.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2019(x, :) = cell2019(rowx, :);      %these two cells contain equal player order
        organized_2018(x, :) = cell2018(i, :);       % both contain the same players
        x = x + 1;
    end
    
end

X18 = organized_2018(:, [3:13 end]);
y18 = organized_2018(:, 14);
X19 = organized_2019(:, [3:13 end]);
y19 = organized_2019(:, 14);
X18_19 = cell2mat(X19) - cell2mat(X18);
y18_19 = cell2mat(y19) - cell2mat(y18);


%19-20 training data
data19_20 = [data19; data20(:,[2:end])];
%remove players from 2018 that arent in 2019/ 2018&2019 need equal order
data20 = data20(:,[2:end]);
cell2019 = table2cell(data19);
cell2020 = table2cell(data20);
[row, col] = size(data19);
organized_2019 = cell(row, col);
organized_2020 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data20.Name, data19.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2020(x, :) = cell2020(rowx, :);      %these two cells contain equal player order
        organized_2019(x, :) = cell2019(i, :);       % both contain the same players
        x = x + 1;
    end
    
end

X19 = organized_2019(:, [3:13 end]);
y19 = organized_2019(:, 14);
X20 = organized_2020(:, [3:13 end]);
y20 = organized_2020(:, 14);
X19_20 = cell2mat(X20) - cell2mat(X19);
y19_20 = cell2mat(y20) - cell2mat(y19);

%completed training/validation/test data
%15-18 (training)
Xtrain = [X15_16; X16_17; X17_18];
Xtrain = Xtrain(:, 2:11);
ytrain = [y15_16; y16_17; y17_18];
%18-19 (validation)
Xval = X18_19;
Xval = Xval(:, 2:11);
yval = y18_19;
%19-20 (test)
Xtest = X19_20;
Xtest = Xtest(:,2:11);
ytest = y19_20;

