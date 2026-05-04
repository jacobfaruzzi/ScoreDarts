function setupCricket(src)
appData = getappData(src);
appData.numPlayers = appData.numPlayersBtn.Value;

appData = setupTable(appData);

appData = setupButtons(appData);
appData.multiplier = 1;
appData.currPlayerIdx = find(strcmp(appData.cricketTable.ColumnName ,"Player 1"));
appData.currPlayerTurn = 1;
s = uistyle('BackgroundColor', 'yellow');
addStyle(appData.cricketTable, s, 'column', appData.currPlayerIdx);

setappData(appData);
end

function appData = setupTable(appData)
appData.cricketPanel = uipanel(appData.mainFig,"Position",[10 10 980 980]);
appData.Players = "Player " + string(1:appData.numPlayers);

if appData.numPlayers == 1
    varName = [appData.Players "-"];
else
    idx = floor(appData.numPlayers/2+1);
    varName1 = appData.Players(1:idx-1);
    varName2 = appData.Players(idx:end);
    varName = [varName1 "-" varName2];
end


c = strings(8,appData.numPlayers+1);
c(1,:) = "0";
cricketData = array2table(c,"VariableNames",varName);

appData.cricketTable = uitable(appData.cricketPanel,"Data",cricketData,'OuterPosition',[10 390 960 391.5],"CellSelectionCallback",@cellSelected,'FontSize',30);
appData.cricketTable.Data.("-")(1) = "SCORE";
appData.cricketTable.Data.("-")(2) = "15";
appData.cricketTable.Data.("-")(3) = "16";
appData.cricketTable.Data.("-")(4) = "17";
appData.cricketTable.Data.("-")(5) = "18";
appData.cricketTable.Data.("-")(6) = "19";
appData.cricketTable.Data.("-")(7) = "20";
appData.cricketTable.Data.("-")(8) = "B";
Style = uistyle("HorizontalAlignment",'center','BackgroundColor', [1 1 1]);
addStyle(appData.cricketTable, Style);
end

function appData = setupButtons(appData)

appData.fifteen = uibutton(appData.cricketPanel,'Position',[10 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"15");
appData.sixteen = uibutton(appData.cricketPanel,'Position',[101.875 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"16");
appData.seventeen = uibutton(appData.cricketPanel,'Position',[193.75 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"17");
appData.eightteen = uibutton(appData.cricketPanel,'Position',[285.625 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"18");
appData.nineteen = uibutton(appData.cricketPanel,'Position',[377.5 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"19");
appData.twenty = uibutton(appData.cricketPanel,'Position',[469.375 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"20");
appData.bullseye = uibutton(appData.cricketPanel,'Position',[561.25 200 86.875 50],"ButtonPushedFcn",@cricketScore,'Text',"B");
appData.miss = uibutton(appData.cricketPanel,'Position',[653.125 200 86.875 50],'BackgroundColor',[0.725,0.282,0.306],"ButtonPushedFcn",@cricketScore,'Text',"MISS");

appData.single = uibutton(appData.cricketPanel,'Position',[745 255 225 50],'BackgroundColor',[0.4 0.6 0.8],"ButtonPushedFcn",@multipier,'Text',"Single");
appData.double = uibutton(appData.cricketPanel,'Position',[745 200 225 50],"ButtonPushedFcn",@multipier,'Text',"Double");
appData.triple = uibutton(appData.cricketPanel,'Position',[745 145 225 50],"ButtonPushedFcn",@multipier,'Text',"Triple");
end

function cellSelected(src, event)
appData = getappData(src.Parent.Parent);
if ~isempty(event.Indices)
    appData.cricketTable.Selection = [];
end
setappData(appData);
end

function multipier(src,~)
appData = getappData(src.Parent.Parent);
currMult = src.Text;
switch currMult
    case "Single"
        set(appData.single,'BackgroundColor',[0.4 0.6 0.8]);
        set(appData.double,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.triple,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.bullseye,'Enable','on');
        appData.multiplier = 1;
    case "Double"
        set(appData.single,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.double,'BackgroundColor',[0.4 0.6 0.8]);
        set(appData.triple,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.bullseye,'Enable','on');
        appData.multiplier = 2;
    case "Triple"
        set(appData.single,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.double,'BackgroundColor',[0.9600 0.9600 0.9600]);
        set(appData.triple,'BackgroundColor',[0.4 0.6 0.8]);
        set(appData.bullseye,'Enable','off');
        appData.multiplier = 3;
end

setappData(appData);
end