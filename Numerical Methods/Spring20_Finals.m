%% Spring 20 Finals (100 points)
%
% *Assigned on: 05/11/20 3:00 PM*
%
% *Notes*
%
% # *Deadline: 05/15/20 11:59 AM*
% # *Submit before the deadline*: delayed submissions will be penalized at
% 20% reduction in earned points
% # Please upload the *published document* as well as the *zipped folder* to
% canvas and download your submitted files to ensure we can reproduce your
% results
% # Look at the solution manuals for assignments. You are allowed to borrow
% functions from previous assignments.
%%
clear; clc; close all
fig = 0;
%% Problem 1: Root Finding and Optimization (30 points)
%
% You are given the following quadratic function:
%
% $f(x) = x^2 -3.5x +2$ 
%
% *1a (10 points)*
%
% Use the Newton-Raphson method to find one of the roots with an initial
% guess of |xinit = 4|, maximum iterations at 100, and tolerance at
% |1.E-6|. Report the root and number of iterations.
%
% *Answer*
%
f = @(x)(x.^2 - 3.5.*x +2);
xinit = 4;
tol = .000001;
maxitr=100;

[root,~,iter] = NewtonRaphsonFinal(f,xinit,tol,maxitr);

fprintf('\nThe roots are %4.4f, with a total of %d iterations ',root,iter);
%%
% *1b (10 points)*
%
% Modify the function in *1a* so that you can use the Gradient-descent method to 
% find one of the roots with an initial guess of |xinit = 3|, maximum 
% iterations at 100, tolerance at |1.E-6|, and gamma ($\gamma$) value of
% 0.1.
% Report the root and number of iterations.
%
% *Answer*
%
f = @(x)((x.^2 - 3.5.*x +2)).^2;
xinit = 3;
maxitr = 100;
tol = .000001;
gamma = .1;
degree = 2;

[iter,xopt,xopt_st] = GradientFinal(xinit,f,gamma,tol,maxitr);
fprintf('\nGradient Descent with a modified function shows a root to x = %4.4f after %d iterations',xopt,iter);
%%
% *1c (10 points)*
%
% Let us consider another function $h(x) = x^3-6x^2+11x-5$. How many roots 
% does this function have? Plot this function for |x = (0.5:0.01:3.25)| to see visually.
% As in problem *1b* you can modify the function so that you can find 
% the roots using gradient descent.
% For modified function do all the minima correspond to the roots? What
% trouble can the gradient descent get into. Plot $h(x)$ and the modified
% function on the same plot to see this.
%
% *Answer*
% This original function has 1 real and 2 imaginary roots. For the modified function, 
% not all minima correspond to the (real) roots since one minima doesnt touch the x-axis. 

h=@(x)(x.^3-6.*x.^2+11.*x-5);
hmod=@(x)((x.^3-6.*x.^2+11.*x-5).^2);
x = (0.5:0.01:3.25);


fig = fig+1;
figure(fig)
plot(x,h(x))
hold on
plot(x,hmod(x))
xlabel('x')
ylabel('y')
title('Problem 1c')
hold off

xinit = .5;
maxitr = 100;
tol = .000001;
gamma = .05;

[iterr,xoptt,xopt_st] = GradientFinal(xinit,hmod,gamma,tol,maxitr);
fprintf('\nThe originial function h has a root at x=%1.2f after %d iterations',xoptt,iterr);
%% Problem 2: Iterative Linear Solver (30 points)
%
% *2a (15 points)*
% You are given the following system of equations:
%
% $2x_{1} + 5x_{2} = 4$
%
% $4x_{1} + 3x_{2} = 1$
%
% The iterative solvers will not work if you try solving this system of 
% equations? Why? Modify the system so that you can use iterative linear 
% solver to find the solution $[x_{1} \quad x_{2}]^{T}$. Use Jacobi method
% with maximum iterations 50, tolerance of |1.E-6|, and 2-norm to evaluate
% the answer with an initial guess for $x =[0 \quad 0]^{T}$.
%
% *Answer*
% The iterative solvers won't work for this system. You cannot use the Jacobi method to solve the above 
% system since it needs a diagonally dominant system. 
% With a reduced row eschelon form of the equations,
% it can be solved due to pivot columns and a simplified diagonal.
errtype = 2;
Aa =[2 5; 4 3];
bb = [4 1]';

x = [Aa bb];
R = rref(x);

A = R(1:2,1:2);
b = R(1:2,3);

tol = 0.00001;
maxitr = 50;
n = length(A);
xinit = zeros(n,1);

[errnorms,err,iter,xn]=JacobiFinal(A,b,maxitr,tol,xinit);

fprintf('\nSolution for modified system: %4.4f, %4.4f after %d iterations',xn,iter);
%%
% *2b (15 points)*
%
% Let us now consider the following system of equations:
%
% $2x_{1} + 5x_{2} + 1x_{3} = 4$
%
% $4x_{1} + 3x_{2} + 1x_{3}= 1$
%
% $7x_{1} + 6x_{2} + 1x_{3}= 2$
% 
% Can you use Jacobi method to solve the above system of equations? Why?
% What is the number of iterations that Jacobi method takes to solve the
% system with maximum iterations 100, tolerance of |1.E-6|, and 2-norm for 
% error calculation with an initial guess for $x =[0 \quad 0 \quad 0]^{T}$.
%
% *Answer*
% Maximum number of iterations are exceeded with high error with the original system of equations with the jacobi method, the answer is
% incorrect. However, with row reducing, an answer can be reached. You cannot use the Jacobi method to solve the above system since it needs a diagonally dominant system. 
% With a reduced row eschelon form of the equations,
% it can be solved due to pivot columns and a simplified diagonal.
tol = 0.00001;
maxitr = 100;
xinit = [0 0 0]';

Aaa = [2 5 1; 4 3 1; 7 6 1];
bbb = [4 1 2]';

[errnorms,err,iter,xn]=JacobiFinal(Aaa,bbb,maxitr,tol,xinit);

x2 = [Aaa bbb];
Rr = rref(x2);

A2 = Rr(1:3,1:3);
b2 = Rr(1:3,4);

[errnorms,err,iter,xn]=JacobiFinal(A2,b2,maxitr,tol,xinit);

fprintf('\nSolution for modified system: %4.4f, %4.4f, %4.4f after %d iterations',xn,iter);

%%

%% Problem 3: Least Squares Regression (40 points)
%
% *3a* (20 points)
%
% You are given the dataset (x1,y1) plotted below:
load P3a_data.mat
fig = fig+1;
figure(fig)
plot(x1,y1,'ob')
xlabel('x1')
ylabel('y1')
title('Problem 3a')
hold on

%%
% What polynomial order function will fit this data well? Output the regressed
% polynomial coefficients, and r^2 value in the command window.
% Display your regressed curve in the plot as a red line with the original
% data as blue circles.
%
% *Answer*
%This will fit a 4th order polynomial well.

poly_order = 4;
x1_poly = x1.^(1:poly_order);
[coeffs2,r2_1,y_pred] = lin_regressFinal(x1_poly,y1);
fprintf('\nThe polynomial coefficients are %4.4f,%4.4f,%4.4f,%4.4f,%4.4f, with an r^2 value of %4.4f',coeffs2,r2_1);

plot(x1,y_pred,'-r')
title(sprintf('Problem 3a.: r^2 = %1.3f',r2_1))
hold off
%%
% *3b (20 points)*
%
% You are given the following multiple linear data with two independent
% (x2 with two columns) and one dependent data vectors (y2 with one column)

load P3b_data.mat
fig = fig+1;
figure(fig)
scatter3(x2(:,1),x2(:,2),y2,'ok')
xlabel('x2^{(1)}')
ylabel('x2^{(2)}')
zlabel('y2')
title('Problem 3b')
hold on
%%
% Report the regressed multiple linear coefficients, and r^2 value in the
% output window. Plot the regressed plane on top of the scatter
% plot using |meshgrid()| to visulaize your fit.
%
% *Answer*
%


[coeffs2,r2_2,y_pred] = lin_regressFinal(x2,y2);
fprintf('\nThe polynomial coefficients are %4.4f,%4.4f,%4.4f with an r^2 value of %4.4f',coeffs2,r2_2);

X = [ones(size(x2(:,1))) x2(:,1) x2(:,2) x2(:,1).*x2(:,2)];
b = regress(y2,X);

x1m = x2(:,1);
x2m = x2(:,2);
[X1M,X2M] = meshgrid(x1m,x2m);
YM = b(1) + b(2)*X1M + b(3)*X2M + b(4)*X1M.*X2M;
surf(X1M,X2M,YM)

hold off
