% Jacobi
function[errnorms,err,iter,xn]=JacobiFinal(A,b,maxitr,tol,xn)
iter = 0;
err = 1;
xold = xn;

%vectorized method
%diag(A) returns column vector with diagonal entries of A
b = b./diag(A); %b is a column vector
A = A./diag(A);
A = A-diag(diag(A));

while iter<maxitr&&err>tol
    
    xn = (b-A*xn); %Jacobi method
           
    iter=iter+1;
    errnorms(iter,:)=errnorm(xn-xold)./errnorm(xn);
    err=errnorms(iter,2);
    xold=xn;
    
    
end
end