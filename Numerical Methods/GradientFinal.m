
function [iter,xinit,xopt_st] = GradientFinal(xinit,f,gamma,tol,maxiter)
xopt_old = 1.2*xinit;


% Automatic differentiation

syms xsym
df = matlabFunction(diff(f(xsym)));

iter = 0;
err = 1;

while err>tol && iter < maxiter
    xinit = xinit - gamma* df(xinit);
    err = abs((xinit-xopt_old)/xinit);
    xopt_old = xinit;
    iter = iter+1;
    xopt_st(iter) = xinit;
end

end