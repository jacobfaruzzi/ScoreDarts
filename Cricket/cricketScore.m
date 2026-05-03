function cricketScore(src,~)
appData = getappData(src.Parent.Parent);
isScore = false;
idx = find(strcmp(appData.cricketTable.ColumnName ,appData.Players(appData.currPlayerIdx)));
currPlayer = string(appData.cricketTable.ColumnName(idx));

scoreIdx = find(appData.cricketTable.Data.("-") == src.Text);

if appData.cricketTable.Data.(currPlayer)(scoreIdx) == ""
    subMult = 3;
elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  "/"
    subMult = 2;
elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  "X"
    subMult = 1;
elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  char(8855)
    subMult = 0;
end

for i = 1:appData.multiplier
    if appData.cricketTable.Data.(currPlayer)(scoreIdx) == ""
        appData.cricketTable.Data.(currPlayer)(scoreIdx) = "/";
    elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  "/"
        appData.cricketTable.Data.(currPlayer)(scoreIdx) = "X";
    elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  "X"
        appData.cricketTable.Data.(currPlayer)(scoreIdx) = char(8855);
    elseif appData.cricketTable.Data.(currPlayer)(scoreIdx) ==  char(8855)
        isScore = true;
    end
end
currScore = appData.cricketTable.Data.("-")(scoreIdx);
if isScore
    if currScore == "B"
        addScore = 25;
    else
        addScore = str2double(currScore);
    end
    idxScore = find(appData.cricketTable.Data{scoreIdx,:} ~= char(8855));
    idxScore = idxScore(idxScore ~= find(strcmp(appData.cricketTable.ColumnName ,"-")));
    heading = string(appData.cricketTable.ColumnName);
    for i = idxScore
        appData.cricketTable.Data.(heading(i))(1) = string(str2double(appData.cricketTable.Data.(heading(i))(1))+addScore*(appData.multiplier-subMult));
    end
end
% Add Winning Logic Here
if sum(appData.cricketTable.Data.(currPlayer) == char(8855)) == 7 && appData.numPlayers > 2 && ...
        sum(str2double(appData.cricketTable.Data.(currPlayer)(1)) < str2double(appData.cricketTable.Data{1,(~isnan(str2double(appData.cricketTable.Data{1,:})))})) == appData.numPlayers-1
    [place,appData] = setPosition(currPlayer,appData);
    msg = sprintf(currPlayer + " came in " + place + " Place!\n\nWould you like to continue the game?" );
    endConfirm = uiconfirm(appData.mainFig,msg,'Continue Game?','Options',{'Continue','End Game'});
    switch endConfirm
        case 'Continue'
            idx = find(strcmp(appData.cricketTable.ColumnName ,appData.Players(appData.currPlayerIdx)));
            s = uistyle('BackgroundColor', [.5,.5,.5]);
            addStyle(appData.cricketTable, s, 'column', idx);
            appData.Players(appData.currPlayerIdx) = [];
            if appData.currPlayerIdx == appData.numPlayers
                appData.currPlayerIdx = 1;
            else
                appData.currPlayerIdx = appData.currPlayerIdx;
            end
            appData.numPlayers = appData.numPlayers-1;
            idx = find(strcmp(appData.cricketTable.ColumnName ,appData.Players(appData.currPlayerIdx)));
            s = uistyle('BackgroundColor', 'yellow');
            addStyle(appData.cricketTable, s, 'column', idx);
            appData.currPlayerTurn = 0;
        case 'End Game'
            [~,appData] = setPosition(currPlayer,appData);
            gaveOver(appData);
            return;
    end
elseif sum(appData.cricketTable.Data.(currPlayer) == char(8855)) == 7 && appData.numPlayers <= 2 && ...
        sum(str2double(appData.cricketTable.Data.(currPlayer)(1)) < str2double(appData.cricketTable.Data{1,(~isnan(str2double(appData.cricketTable.Data{1,:})))})) == appData.numPlayers-1
    [~,appData] = setPosition(currPlayer,appData);
    gaveOver(appData);
    return;
end
% ----------------------
if appData.currPlayerTurn == 3
    s = uistyle('BackgroundColor', [1 1 1]);
    addStyle(appData.cricketTable, s, 'column', idx);
    appData.currPlayerTurn = 1;
    if appData.currPlayerIdx == appData.numPlayers
        appData.currPlayerIdx = 1;
    else
        appData.currPlayerIdx = appData.currPlayerIdx+1;
    end
    idx = find(strcmp(appData.cricketTable.ColumnName ,appData.Players(appData.currPlayerIdx)));
    s = uistyle('BackgroundColor', 'yellow');
    addStyle(appData.cricketTable, s, 'column', idx);
else
    appData.currPlayerTurn = appData.currPlayerTurn+1;
end
setappData(appData);
end

function gaveOver(appData)
[players,places] = getFinalCricketPos(appData);
msg = sprintf("%s\n\n",places + " Place " + players);
endConfrim = uiconfirm(appData.mainFig,msg,'Game Over','Options',{'Play Again','Main Menu'});
appData = rmfield(appData,'Position');
appData.mainFig.UserData = appData;
switch endConfrim
    case 'Play Again'               
        setupCricket(appData.mainFig);
    case 'Main Menu'
        newFigure(appData);
end
end