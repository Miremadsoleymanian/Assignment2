
function f=multinorm(n,mu,sigma)

    
    nrow= size(mu,1);
    stnorm= normrnd(0,1,[nrow,n]);
    
    A=sigma^0.5;
    
    f= mu+ A*stnorm;   

end 

