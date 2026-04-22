function setupGame(src,~)

appData = getappData(src);

appData.startPanel.Visible = 'off';

game = appData.gameSelect.Value;
setupgameFcn = sprintf('setup%s(src);',game);
eval(setupgameFcn);

end