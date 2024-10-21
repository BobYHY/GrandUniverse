clc;
rng(0);
warning('off', 'all');

organismList = unique({S.Organism});
maxfamilynum = length(organismList);
N=length(S);
M=10000; 
oo=16;  %order of nv
vec=zeros(N, 4*(oo+1));
trueord=zeros(N,1);
for i = 1:N
    vec(i,:) = [S(i).NV(1:1+oo) S(i).NV(22:22+oo) S(i).NV(43:43+oo) S(i).NV(64:64+oo)];
    organismStr = S(i).Organism;
    idx = find(strcmp(organismList, organismStr));
    trueord(i,:) = idx;  
end
maxx=max(abs(vec),[],1);
maxx(maxx == 0) = 1;
Maxx=repmat(maxx,N,1);
vec=M*vec./Maxx;

ord=trueord;
insectnum=0;
disjointnum=0;
for i=1:maxfamilynum-1
    for j=i+1:maxfamilynum   
        iseq=vec(ord(:,1)==i,:);
        jseq=vec(ord(:,1)==j,:);
        [val,T]=intersection(iseq,jseq);
        if T==0
            insectnum=insectnum+1;
        else
            disjointnum=disjointnum+1;
        end
        fprintf('%d %d %d %d\n', i,j,insectnum,disjointnum)
    end
end
