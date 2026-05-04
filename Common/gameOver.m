function gameOver(appData)
[players,places] = getFinalPos(appData);
msg = sprintf("%s\n\n",places + " Place " + players);
endConfrim = uiconfirm(appData.mainFig,msg,'Game Over','Options',{'Play Again','Main Menu'},'Icon','none');
appData = rmfield(appData,'Position');
appData.mainFig.UserData = appData;
switch endConfrim
    case 'Play Again'
        switch appData.gameSelect.Value
            case 'Cricket'
                setupCricket(appData.mainFig);
            otherwise
                setupX01(appData.mainFig);
        end
    case 'Main Menu'
        newFigure(appData);
end
end