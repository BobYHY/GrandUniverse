function [knv] = kmernv(seq,k)
    len = length(seq) - k + 1;
    knv = zeros(1,3*4^k);
    for i = 1 : len
        seqtmp = seq(i : i + k - 1);
        temp = dnacode(k,seqtmp);
        knv(1,temp + 1) = knv(1,temp + 1) + 1;
        knv(1,4^k + temp + 1) = knv(1,4^k + temp + 1) + i;
        knv(1,2 * 4^k + temp + 1) = knv(1,2 * 4^k + temp + 1) + i^2;
    end
    for j = 1 : 4^k
        t = knv(1,4^k + j);
        if knv(1,j) ~= 0
            knv(1,4^k + j) = t / knv(1,j);
            knv(1,2 * 4^k + j) = (knv(1,2 * 4^k + j)- t^2 / knv(1,j)) / (knv(1,j)*len);
        end
    end
end