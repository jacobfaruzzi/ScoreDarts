function [players,places] = getFinalPos(appData)
switch appData.gameSelect.Value
    case 'Cricket'
        table = "cricketTable";
        idx = find(strcmp(appData.cricketTable.ColumnName ,appData.Players(appData.currPlayerIdx)));
        currPlayer = string(appData.cricketTable.ColumnName(idx));
        condition = (sum(table2array(appData.(table).Data) == char(8855)) ~= 7 | (appData.(table).ColumnName == currPlayer)') & (appData.(table).ColumnName ~= "-")';
    otherwise
        table = "X01Table";
        condition = str2double(appData.(table).Data(1,:).Variables) ~= 0;
end
currPos = struct2table(appData.Position);

remPlayers = (~isnan(str2double(appData.(table).Data(1,:).Variables)) & condition);
remNames = string(appData.(table).ColumnName(remPlayers));
if ~isempty(remNames)
remScores = str2double(appData.(table).Data{1,remNames});

[~,idx] = sort(remScores,"ascend");

remNames = remNames(idx);
remPos = numToOrdinal((height(currPos)+1: + height(currPos)+numel(remNames))');

tempTable(:,1) = remNames;
tempTable(:,2) = remPos;

addRows = array2table(tempTable,"VariableNames",{'player','place'});

currPos = [currPos;addRows];
end
players = currPos.("player");
places = currPos.("place");

end