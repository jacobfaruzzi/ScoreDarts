function [place,appData] = setPosition(player,appData)
if ~isfield(appData,'Position')
    appData.Position.player = player;
    place = numToOrdinal(length(appData.Position));
    appData.Position.place = place;
else
    appData.Position(end+1).player = player;
    place = numToOrdinal(length(appData.Position));
    appData.Position(length(appData.Position)).place = place;
end
end