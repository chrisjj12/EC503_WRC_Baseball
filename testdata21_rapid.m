data19 = readtable('Fangraphs Leaderboard19 (Rapid) .xlsx');
data21 = readtable('Fangraphs Leaderboard21 (Rapid).xlsx');

%15-16 training data

data19_21 = [data19; data21];
%remove players from 2015 that arent in 2016/ 2015&2016 need equal order
cell2021 = table2cell(data21);
cell2019 = table2cell(data19);
[row, col] = size(data19);
organized_2021 = cell(row, col);
organized_2019 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data21.Name, data19.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2021(x, :) = cell2021(rowx, :);      %these two cells contain equal player order
        organized_2019(x, :) = cell2019(i, :);       % both contain the same players
        x = x + 1;
    end
    
end

X19 = organized_2019(:, 4:13);
y19 = organized_2019(:, 14);
X21 = organized_2021(:, 4:13);
y21 = organized_2021(:, 14);
X19_21 = cell2mat(X21) - cell2mat(X19);
y19_21 = cell2mat(y21) - cell2mat(y19);

X21_test_rapid = X19_21;
y21_test_rapid = y19_21;