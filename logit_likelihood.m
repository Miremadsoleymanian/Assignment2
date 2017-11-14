function output=logit_likelihood(X,Y,beta,m)

beta=kron(eye(m),beta);
temp=X*beta;

exp_temp = exp(temp);

for j=1:m-1
prob(:,j)=exp_temp(:,j)./sum(exp_temp,2);
end
prob(:,m)=1-sum(prob(:,1:m-1),2);

y=Y-1;
output = sum(y .* log(prob(:,2)) + (1-y) .* log(prob(:,1)));

end

