function [a,r2,y_pred] = lin_regressFinal(x,y)
[n,m] = size(x);

% making sure the rows are number of samples and columns are
% features
if (m+1>n)
    a = n;
    n = m;
    m = a;
    x = x';
    y = y';
end

z = zeros(n,m+1);
z(:,1) = 1;
z(:,2:m+1)  = x(:,1:m);

z'*z;
z'*y;
a = (z'*z)\(z'*y);

y1 = y - mean(y);
St = y1'*y1;
z1 = (y-z*a);
Sr = z1'*z1;
r2 = 1- Sr/St;

y_pred = z*a;
end