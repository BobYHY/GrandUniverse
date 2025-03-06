function T = intersection(mutset0,mutset00);
%Input:
%      mutset0 is m*col dimensional matrix
%      mutset00 is n*col dimensional matrix
%Output:
%      The two point cloud is disjoint if T = 1, or T = 0

%The program aims to solve the linear programming problem
options = optimoptions('linprog', 'Display', 'off');
[m,l]=size(mutset0);
[n,l]=size(mutset00);
c=ones(m+n,1);
A0=[mutset0',-mutset00'];
a1=[ones(1,m),zeros(1,n)];
b1=[zeros(1,m),ones(1,n)];
Aeq=[A0;a1;b1];
beq=[zeros(l,1);1;1];
lb=zeros(m+n,1);
ub=ones(m+n,1);
[s,fval]=linprog(c,[],[],Aeq,beq,lb,ub,options);
if length(s)==0
    T=1;
else 
    T=0;
end
end
