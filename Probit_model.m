clear
X1=unifrnd(0,1,[1000,1]);
X2=unifrnd(0,1,[1000,1]);
X=[repelem(1,1000)',X1,X2];
%X=[X1,X2];
sigma=1;
beta0=3;
beta1=5;
beta2=-10;
Z=beta0+beta1.*X1+beta2.*X2+normrnd(0,sigma,[1000,1]);
Y=double(logical(Z>0));

B0=(X'*X)^-1*X'*Y;
A0=eye(3);

result=probit(X,Y,10000,B0,A0);

function output= probit(X,Y,iteration,B0,A0)

beta(:,1)=multinorm(1,B0,A0);
for i=1:size(Y,1)
if Y(i)==1
    a(i,1)=0;
    b(i,1)=inf;
else
    a(i,1)=-inf;
    b(i,1)=0;
end
end 
ZZ(:,1)=trandn(a,b);
A_tilda=((A0^-1)+X'*X)^-1;
%AA=(X'*X)^-1;
for i=1:iteration

 ZZ(:,i)=X*beta(:,i)+trandn(a-(X*beta(:,i)),b-(X*beta(:,i)));
 %beta_tilda(:,i)=A_tilda*((A0^-1)*B0+X'*ZZ(:,i));
 beta_hat = (X'*X)^-1*(X'*ZZ(:,i));
 beta(:,i+1)=multinorm(1,beta_hat,(X'*X)^-1);
 
 
end

output=beta;

end

