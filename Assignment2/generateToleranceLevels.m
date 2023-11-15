function toleranceList = generateToleranceLevels(expLow,expHigh)
    toleranceList = [];

    for exponent = expLow:1:expHigh
        for i =1:9
            toleranceList = [toleranceList, i*10^(exponent)];
        end
    end
end