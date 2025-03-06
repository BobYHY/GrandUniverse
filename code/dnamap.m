function [index] = dnamap(letter)
    if (letter == 'A' || letter == 'a')
        index = 0;
    elseif (letter == 'C' || letter == 'c')
        index = 1;
    elseif (letter == 'G' || letter == 'g')
        index = 2;
    elseif (letter == 'T' || letter == 't')
        index = 3;
    else
        index = 4;
    end
end