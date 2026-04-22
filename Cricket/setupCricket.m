function setupCricket(src)
appData = getappData(src);

appData.numPlayers = appData.numPlayers.Value;

appData.cricketPanel = uipanel(appData.mainFig,"Position",[10 10 980 980]);
varNameTemp = "Player " + string(1:appData.numPlayers);

    idx = floor(appData.numPlayers/2+1);
    varName1 = varNameTemp(1:idx-1);
    varName2 = varNameTemp(idx:end);
    varName = [varName1 "-" varName2];


c = cell(7,appData.numPlayers+1);
critcketData = cell2table(c,"VariableNames",varName);

appData.cricketTable = uitable(appData.cricketPanel,"Data",critcketData,'OuterPosition',[10 390 960 195],"CellSelectionCallback",@cricketScore);
appData.cricketTable.Data.("-")(1) = {"15"};
appData.cricketTable.Data.("-")(2) = {"16"};
appData.cricketTable.Data.("-")(3) = {"17"};
appData.cricketTable.Data.("-")(4) = {"18"};
appData.cricketTable.Data.("-")(5) = {"19"};
appData.cricketTable.Data.("-")(6) = {"20"};
appData.cricketTable.Data.("-")(7) = {"B"};

setappData(appData);
end