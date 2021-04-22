
data19 = readtable('Fangraphs Leaderboard19.xlsx');
data21 = readtable('Fangraphs Leaderboard21.xlsx');

%15-16 training data
data19_21 = [data19; data21];
%remove players from 2015 that arent in 2016/ 2015&2016 need equal order
cell2021 = table2cell(data21);
cell2019 = table2cell(data19);
[row, col] = size(data21);

organized_2021 = cell(row, col);
organized_2019 = cell(row, col);
x = 1;
for i = 1:row
    idx1 = strcmp(data19.Name, data21.Name(i));
    [rowx, ~] = find(idx1 == 1);
    if isempty(rowx) == 0
        organized_2021(x, :) = cell2021(i, :);      %these two cells contain equal player order
        organized_2019(x, :) = cell2019(rowx, :);       % both contain the same players
        x = x + 1;
    end
    
end
organized_2021 = organized_2021(1:130,:);
organized_2019 = organized_2019(1:130,:);

X19 = organized_2019(:, [3:12 14:end-1]);
y19 = organized_2019(:, 13);
X21 = organized_2021(:, [3:12 14:end-1]);
y21 = organized_2021(:, 13);
X19_21 = cell2mat(X21) - cell2mat(X19);
y19_21 = cell2mat(y21) - cell2mat(y19);

X21_test_raw = X19_21;
y21_test_raw = y19_21;