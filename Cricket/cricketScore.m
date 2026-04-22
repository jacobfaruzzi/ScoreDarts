function cricketScore(src,event)
appData = getappData(src.Parent.Parent);


firstStyle = uistyle('Icon', 'cricket1.png', 'IconAlignment', 'center');
addStyle(appData.cricketTable, firstStyle, 'cell', event.Indices);   % Icon for FileB
end