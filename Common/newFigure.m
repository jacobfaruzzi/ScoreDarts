function newFigure(appData)

screenSize = get(0,'screensize');
if ~isfield(appData,'mainFig')
    close(findall(groot, 'Type', 'figure', 'Name', 'Darts Scoreboard'))
    appData.mainFig = uifigure("Name","Darts Scoreboard","Position",[(screenSize(3)-1000)/2 (screenSize(4)-1000)/2 1000 1000],'Resize','off');
else

end
appData.startPanel = uipanel(appData.mainFig,"Position",[10 10 980 980]);


appData.numPlayersBtn = uieditfield(appData.startPanel, 'numeric', 'Position', [380 350 200 80], 'Value', 1, 'Limits', [1 8]);

appData.minusBtn = uibutton(appData.startPanel, 'Text', '-','Position', [330 350 50 80],'ButtonPushedFcn', @(btn, event) incrementValue(appData.numPlayersBtn, -1));

appData.plusBtn = uibutton(appData.startPanel, 'Text', '+', 'Position', [580 350 50 80], 'ButtonPushedFcn', @(btn, event) incrementValue(appData.numPlayersBtn, 1));


uitextarea(appData.startPanel,"Position",[330 330 85 20],"Value","Game Modes");
Modes = {'Cricket','101','201','301','401','501','601','701','801','901','1001'};
appData.gameSelect = uidropdown(appData.startPanel,"Items",Modes,"Position",[330 250 300 80],"ValueChangedFcn",@gameChange);

uitextarea(appData.startPanel,"Position",[330 230 90 20],"Value","Game Settings");
modeSettings = {};
appData.gameSettings = uidropdown(appData.startPanel,"Items",modeSettings,"Position",[330 150 300 80]);
appData.startGame = uibutton(appData.startPanel,"Text","Start Game","Position",[330 50 300 50],"UserData",appData,"ButtonPushedFcn",@setupGame);

setappData(appData);
end

% Callback function to update value
function incrementValue(obj, step)
    % Update the value while respecting defined limits
    newValue = obj.Value + step;
    if newValue >= obj.Limits(1) && newValue <= obj.Limits(2)
        obj.Value = newValue;
    end
end

function gameChange(src,~)
appData = getappData(src.Parent.Parent);
if contains(src.Value,'Cricket')
    modeSettings = {};
    % modeSettings = {'Cut Throat','Normal}; % Provisioning to add normal
    % mode, currently scores as cut throat
    

elseif contains(src.Value,'01')
    modeSettings = {...
        'Straight In/Straight Out',...
        'Straight In/Double Out',...
        'Straight In/Master Out',...
        'Double In/Straight Out',...
        'Double In/Double Out',...
        'Double In/Master Out',...
        'Triple In/Straight Out',...
        'Triple In/Double Out',...
        'Triple In/Master Out'};
end
appData.gameSettings.Items = modeSettings;
setappData(appData);
end