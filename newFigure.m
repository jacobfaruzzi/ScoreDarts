function newFigure(appData)

screenSize = get(0,'screensize');
if ~isfield(appData,'mainFig')
    close(findall(groot, 'Type', 'figure', 'Name', 'Darts Scoreboard'))
    appData.mainFig = uifigure("Name","Darts Scoreboard","Position",[(screenSize(3)-1000)/2 (screenSize(4)-1000)/2 1000 1000],'Resize','off');
else

end
appData.startPanel = uipanel(appData.mainFig,"Position",[10 10 980 980]);


appData.numPlayersBtn = uieditfield(appData.startPanel, 'numeric', 'Position', [380 250 200 80], 'Value', 1, 'Limits', [1 8]);

appData.minusBtn = uibutton(appData.startPanel, 'Text', '-','Position', [330 250 50 80],'ButtonPushedFcn', @(btn, event) incrementValue(appData.numPlayersBtn, -1));

appData.plusBtn = uibutton(appData.startPanel, 'Text', '+', 'Position', [580 250 50 80], 'ButtonPushedFcn', @(btn, event) incrementValue(appData.numPlayersBtn, 1));

appData.gameSelect = uidropdown(appData.startPanel,"Items",{'Cricket','501'},"Position",[330 150 300 80]);

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