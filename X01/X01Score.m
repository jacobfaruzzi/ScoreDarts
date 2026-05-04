function X01Score(src,~)
appData = getappData(src.Parent.Parent);

idx = find(strcmp(appData.X01Table.ColumnName ,appData.Players(appData.currPlayerIdx)));
currPlayer = string(appData.X01Table.ColumnName(idx));


if src.Text == "B"
    numHit = 25;
elseif src.Text == "MISS"
    numHit = 0;
else
    numHit = str2double(src.Text);
end
if appData.currPlayerTurn == 1
    appData.prevScore = str2double(appData.X01Table.Data.(currPlayer)(1));
    appData.currScore = str2double(appData.X01Table.Data.(currPlayer)(1));
    appData.roundScore = 0;
else
    appData.currScore = str2double(appData.X01Table.Data.(currPlayer)(1));
end
currDart = numHit*appData.multiplier;
if appData.currPlayerTurn == 1
appData.X01Table.Data.(currPlayer)(2:5) = "";
end

if src.Text ~= "MISS"
    appData.X01Table.Data.(currPlayer)(appData.currPlayerTurn+1) = src.Text + " (x" + string(appData.multiplier)+")";
    dartScore = replace(src.Text + " x" + string(appData.multiplier),'x','*');
    appData.roundScore = eval(dartScore)+appData.roundScore;
else
    appData.X01Table.Data.(currPlayer)(appData.currPlayerTurn+1) = src.Text;
end


appData.X01Table.Data.(currPlayer)(5) = string(appData.roundScore);
if currDart > appData.currScore
    appData.X01Table.Data.(currPlayer)(1) = appData.prevScore;
    appData.currPlayerTurn = 3;
appData.X01Table.Data.(currPlayer)(5) = "BUST -- "+string(appData.roundScore);
else
    appData.X01Table.Data.(currPlayer)(1) = appData.currScore-currDart;    
end

if appData.numPlayers > 1 && currDart == appData.currScore
    [place,appData] = setPosition(currPlayer,appData);
    msg = sprintf(currPlayer + " came in " + place + " Place!\n\nWould you like to continue the game?" );
    endConfirm = uiconfirm(appData.mainFig,msg,'Continue Game?','Options',{'Continue','End Game'});
    switch endConfirm
        case 'Continue'
            idx = find(strcmp(appData.X01Table.ColumnName ,appData.Players(appData.currPlayerIdx)));
            s = uistyle('BackgroundColor', [.5,.5,.5]);
            addStyle(appData.X01Table, s, 'column', idx);
            appData.Players(appData.currPlayerIdx) = [];
            if appData.currPlayerIdx == appData.numPlayers
                appData.currPlayerIdx = 1;
            else
                appData.currPlayerIdx = appData.currPlayerIdx;
            end
            appData.numPlayers = appData.numPlayers-1;
            idx = find(strcmp(appData.X01Table.ColumnName ,appData.Players(appData.currPlayerIdx)));
            s = uistyle('BackgroundColor', 'yellow');
            addStyle(appData.X01Table, s, 'column', idx);
            appData.currPlayerTurn = 0;
        case 'End Game'
            gameOver(appData);
            return;
    end
elseif appData.numPlayers == 1 && currDart == appData.currScore
    [~,appData] = setPosition(currPlayer,appData);
    gameOver(appData);
    return;
end

appData = turnCounter(appData);

setappData(appData);
end