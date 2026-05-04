function appData = turnCounter(appData)
switch appData.gameSelect.Value
    case 'Cricket'
        table = "cricketTable";
    otherwise
        table = "X01Table";
end
idx = find(strcmp(appData.(table).ColumnName ,appData.Players(appData.currPlayerIdx)));
if appData.currPlayerTurn == 3
    s = uistyle('BackgroundColor', [1 1 1]);
    addStyle(appData.(table), s, 'column', idx);
    appData.currPlayerTurn = 1;
    if appData.currPlayerIdx == appData.numPlayers
        appData.currPlayerIdx = 1;
    else
        appData.currPlayerIdx = appData.currPlayerIdx+1;
    end
    idx = find(strcmp(appData.(table).ColumnName ,appData.Players(appData.currPlayerIdx)));
    s = uistyle('BackgroundColor', 'yellow');
    addStyle(appData.(table), s, 'column', idx);
else
    appData.currPlayerTurn = appData.currPlayerTurn+1;
end
end