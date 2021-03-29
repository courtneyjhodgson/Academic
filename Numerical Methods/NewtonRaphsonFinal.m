function [root,vec,iter] = NewtonRaphsonFinal(f,xinit,tol,maxiter)
err = 1; % initialize error
iter = 0; % initialize iteration counter

syms xsym
    df = matlabFunction(diff(f(xsym)));
    xm_op = @(f,x,xh)(x-f(x)/df(x));

xmold1 = xinit;
xmold2 = xinit + 0.1;
vec = zeros(1,3);

while err>tol && iter<maxiter
    iter = iter + 1;
    xinit = xm_op(f,xmold1,xmold2);
    
    err = abs((xinit-xmold1)/xinit)*100;
    xmold2 = xmold1;
    xmold1 = xinit;
    
    vec(iter,1) = err;
    vec(iter,2) = xinit;
    vec(iter,3) = f(xinit);
    
end

root = xinit;
end