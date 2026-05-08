function appData = undoBtn(panelName,appData)

switch appData.gameSelect.Value
    case 'Cricket'
        uibutton(appData.(panelName),'Position',[870 10 100 50],'Text','UNDO','ButtonPushedFcn',@undoCricket,'BackgroundColor',[.866 .478 .325]);

    otherwise
        uibutton(appData.(panelName),'Position',[870 10 100 50],'Text','UNDO','ButtonPushedFcn',@undoX01,'BackgroundColor',[.866 .478 .325]);
end

end

function undoCricket(src,~)
appData = getappData(src.Parent.Parent);



setappData(appData);
end

function undoX01(src,~)
appData = getappData(src.Parent.Parent);
idxOld = find(strcmp(appData.X01Table.ColumnName ,appData.Players(appData.currPlayerIdx)));
appData.currPlayerTurn = appData.currPlayerTurn-1;
if appData.currPlayerTurn == 0
    appData.currPlayerTurn = 1;
    appData.currPlayerIdx = appData.currPlayerIdx-1;
    if appData.currPlayerIdx == 0
        appData.currPlayerIdx = numel(appData.Players);        
    end
    appData = switchPlayer(appData,idxOld);
end
setappData(appData);
end

function appData = switchPlayer(appData,idxOld)
switch appData.gameSelect.Value
    case 'Cricket'
        table = "cricketTable";
    otherwise
        table = "X01Table";
end
idxNew = find(strcmp(appData.X01Table.ColumnName ,appData.Players(appData.currPlayerIdx)));
s = uistyle('BackgroundColor', [1 1 1]);
addStyle(appData.(table), s, 'column', idxOld);
s = uistyle('BackgroundColor', 'yellow');
addStyle(appData.(table), s, 'column', idxNew);
end