clear;
rng(314159);
n = 8000;
X1 = mvnrnd([1.5 -2.0], [1.0, 0.4; 0.4, 1.2], n);
X2=  mvnrnd([1.9 -2.3], [1.0, 0.4; 0.4, 1.2], n);
X1 = [ones(n, 1), X1];
X2 = [zeros(n, 1), X2];
X=[X1,X2];

beta_true = [-0.35; 1.8; 0.9];
beta=kron(eye(2),beta_true);
e = random('logistic',0,1,[n 2]);
Z = X*beta + e;
[M,Y]=max(Z,[],2);

result1= metropolislog(X,Y,[0;0;0],10000);

function output = metropolislog(X,Y,beta_in,iteration)

beta_hat(:,1)=beta_in;

for i=1:iteration
   
    beta_can= multinorm(1,beta_hat(:,i),eye(3).*0.002);
    
    a1=logit_likelihood(X,Y,beta_can,2) + log(mvnpdf(beta_can,0,eye(3))) - logit_likelihood(X,Y,beta_hat(:,i),2) - log(mvnpdf(beta_hat(:,i),0,eye(3)));
    alpha=min(exp(a1),1.0);
    %alpha=min((logit_likelihood(X,Y,beta_can,2))/(logit_likelihood(X,Y,beta_hat(:,i),2)),1);
    
    u=unifrnd(0,1);
    
    if (u<alpha)
        beta_hat(:,i+1)=beta_can;
        
    else
        
        beta_hat(:,i+1)=beta_hat(:,i);
        
    end
        

    
end
output=beta_hat;

end