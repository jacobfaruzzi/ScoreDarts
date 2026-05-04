function setupX01(src)
appData = getappData(src);
appData.numPlayers = appData.numPlayersBtn.Value;
checkInOut = appData.gameSettings.Value;
checkIn  = string(extractBefore(checkInOut," In/"));
checkOut = string(extractBetween(checkInOut,"In/"," Out"));
switch checkIn
    case "Straight"
        appData.checkIn = 1;
    case "Double"
        appData.checkIn = 2;
    case "Triple"
       appData.checkIn = 3;
end
switch checkOut
    case "Straight"
        appData.checkOut = 1;
    case "Double"
        appData.checkOut = 2;
    case "Master"
       appData.checkOut = 3;
end
appData = setupTable(appData);

appData = setupButtons(appData);
appData.multiplier = 1;
appData.currPlayerIdx = find(strcmp(appData.X01Table.ColumnName ,"Player 1"));
appData.currPlayerTurn = 1;
s = uistyle('BackgroundColor', 'yellow');
addStyle(appData.X01Table, s, 'column', appData.currPlayerIdx);

setappData(appData);

end


function appData = setupTable(appData)

appData.X01Panel = uipanel(appData.mainFig,"Position",[10 10 980 980]);
appData.Players = "Player " + string(1:appData.numPlayers);

if appData.numPlayers == 1
    varName = [appData.Players "-"];
else
    idx = floor(appData.numPlayers/2+1);
    varName1 = appData.Players(1:idx-1);
    varName2 = appData.Players(idx:end);
    varName = [varName1 "-" varName2];
end

c = strings(5,appData.numPlayers+1);
c(1,:) = appData.gameSelect.Value;
X01Data = array2table(c,"VariableNames",varName);

appData.X01Table = uitable(appData.X01Panel,"Data",X01Data,'OuterPosition',[10 500 960 257.4],"CellSelectionCallback",@cellSelected,'FontSize',30);
appData.X01Table.Data.("-")(1) = "SCORE";
appData.X01Table.Data.("-")(2) = "Dart 1";
appData.X01Table.Data.("-")(3) = "Dart 2";
appData.X01Table.Data.("-")(4) = "Dart 3";
appData.X01Table.Data.("-")(5) = "Total";

Style = uistyle("HorizontalAlignment",'center','BackgroundColor', [1 1 1]);
addStyle(appData.X01Table, Style);
end

function appData = setupButtons(appData)

appData.one = uibutton(appData.X01Panel,'Position',[10 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"1");
appData.two = uibutton(appData.X01Panel,'Position',[101.875 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"2");
appData.three = uibutton(appData.X01Panel,'Position',[193.75 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"3");
appData.four = uibutton(appData.X01Panel,'Position',[285.625 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"4");
appData.five = uibutton(appData.X01Panel,'Position',[377.5 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"5");
appData.six = uibutton(appData.X01Panel,'Position',[469.375 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"6");
appData.seven = uibutton(appData.X01Panel,'Position',[561.25 255 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"7");

appData.eight = uibutton(appData.X01Panel,'Position',[10 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"8");
appData.nine = uibutton(appData.X01Panel,'Position',[101.875 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"9");
appData.ten = uibutton(appData.X01Panel,'Position',[193.75 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"10");
appData.eleven = uibutton(appData.X01Panel,'Position',[285.625 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"11");
appData.tweleve = uibutton(appData.X01Panel,'Position',[377.5 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"12");
appData.thriteen = uibutton(appData.X01Panel,'Position',[469.375 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"13");
appData.fourteen = uibutton(appData.X01Panel,'Position',[561.25 200 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"14");

appData.fifteen = uibutton(appData.X01Panel,'Position',[10 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"15");
appData.sixteen = uibutton(appData.X01Panel,'Position',[101.875 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"16");
appData.seventeen = uibutton(appData.X01Panel,'Position',[193.75 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"17");
appData.eightteen = uibutton(appData.X01Panel,'Position',[285.625 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"18");
appData.nineteen = uibutton(appData.X01Panel,'Position',[377.5 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"19");
appData.twenty = uibutton(appData.X01Panel,'Position',[469.375 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"20");
appData.bullseye = uibutton(appData.X01Panel,'Position',[561.25 145 86.875 50],"ButtonPushedFcn",@X01Score,'Text',"B");
appData.miss = uibutton(appData.X01Panel,'Position',[653.125 145 86.875 160],'BackgroundColor',[0.725,0.282,0.306],"ButtonPushedFcn",@X01Score,'Text',"MISS");

appData.single = uibutton(appData.X01Panel,'Position',[745 255 225 50],'BackgroundColor',[0.4 0.6 0.8],"ButtonPushedFcn",@multipier,'Text',"Single");
appData.double = uibutton(appData.X01Panel,'Position',[745 200 225 50],"ButtonPushedFcn",@multipier,'Text',"Double");
appData.triple = uibutton(appData.X01Panel,'Position',[745 145 225 50],"ButtonPushedFcn",@multipier,'Text',"Triple");
end

function cellSelected(src, event)
appData = getappData(src.Parent.Parent);
if ~isempty(event.Indices)
    appData.X01Table.Selection = [];
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