function [nv] = nv(seq,k)
    len=length(seq);
    nucleotide='ACGT';
    F=[];
    for j=1:4
        C=nucleotide(j);
        D=[];
        D=strfind(seq,C);
        E=[];
        if length(D)==0
            E=zeros(1,k+1);
        else
            E=[length(D) mean(D)];
            for l=2:k
                E=[E sum((D-mean(D)).^l)/(length(D)*len)^(l-1)];
            end
        end
        F=[F E]; 
    end
    nv=F;
end