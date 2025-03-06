function [ind] = dnacode(k,seq)
ind = 0;
    for i = 1 : k
        t = dnamap(seq(i));
        ind = ind + t*4^(i - 1); 
    end
end