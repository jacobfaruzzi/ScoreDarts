function setupGame(src,~)

appData = getappData(src);

appData.startPanel.Visible = 'off';

game = appData.gameSelect.Value;
if contains(game,'01')
game = 'X01';
end
setupgameFcn = sprintf('setup%s(src);',game);
eval(setupgameFcn);

end