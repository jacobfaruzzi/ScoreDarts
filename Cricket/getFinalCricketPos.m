function [players,places] = getFinalCricketPos(appData)

plys(:,1) =    string(appData.cricketTable.ColumnName (find(~strcmp(appData.cricketTable.ColumnName ,"-"))));

plys(:,2) = str2double(table2array(appData.cricketTable.Data(1,find(~strcmp(appData.cricketTable.ColumnName ,"-"))))');
[~,idx]= sort(str2double(plys(:,2)),"ascend");
plys = plys(idx,:);
players = plys(:,1);
places = numToOrdinal(1:numel(idx))';
end