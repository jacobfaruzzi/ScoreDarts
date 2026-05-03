function ordinalStr = numToOrdinal(n)
    % Handles numbers like 1->1st, 2->2nd, 3->3rd, 4->4th...
    num = size(n);
    ordinalStr = strings(num);
    % Get the last two digits to handle 11, 12, 13
    for i = 1:numel(n)
        lastTwo = mod(n(i), 100);
        lastDigit = mod(n(i), 10);

        if lastTwo >= 11 && lastTwo <= 13
            suffix = "th";
        elseif lastDigit == 1
            suffix = "st";
        elseif lastDigit == 2
            suffix = "nd";
        elseif lastDigit == 3
            suffix = "rd";
        else
            suffix = "th";
        end

        ordinalStr(i) = num2str(n(i))+suffix;
    end
end