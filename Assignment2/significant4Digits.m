function [significant4Numbers,significantDigitsCount] = significant4Digits(number)
    % This function returns the siginificant digits and its number 
    % - significantNumber: 
    % - significantDigitCount:

    decimalPlaces = 10;
    numStr = sprintf(['%.' num2str(decimalPlaces) 'f'], number);

    
    % Get index of first and last non-zero number
    indFirstSD = regexp(numStr, '[^0.]', 'once') ;
    indLastSD = length(numStr) - regexp(fliplr(numStr), '[^0]', 'once')+ 1;
   
    % Count the remaining digits
    str = strrep(numStr(indFirstSD:indLastSD), '.', '');
    significantDigitsCount = length(str);
    significant4Numbers = str2num(str(1:4));

end
