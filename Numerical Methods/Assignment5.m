%% Assignment 5 (100 points)
%
% *Notes*
%
% * Deadline: 05/10/20 6PM
% * Please download data.mat from canvas for this assignment
% * One of the lowest scores out of the 5 assignments will be dropped
% * The choice of skipping this assignment is yours. If you did well in
% your previous assignments this will not affect your grade.
%
clear
clc
close all
fig = 0;
load data.mat

%% Problem 1: Straight line fit (50 points)
%
% *1a. (25 points)*
% Write a function to perform least squares regression to a straight line
% $y = a_{0} + a_{1}x$. Fit this straight line to the dataset $(x_{1},y_{1})$.
% Report the coefficients $a_{0}$ and $a_{1}$ that allows you to fit a straight line. 
% 
% *Answer*


[a0_coeff,a1_coeff] = linearsqr(x1,y1)

%%
% *1b. (25 points)*
% Plot the original data as scatter points and the straight line fit or
% approximation on the same figure. Report the coefficient of determination
% ($r^2$) for the goodness of fit.
%
% *Answer*
%

[a0_coeff,a1_coeff] = linearsqr(x1,y1);


xplot = linspace(0,5,100);
yplot = a0_coeff +a1_coeff*xplot;
plot(x1,y1,'.','markersize',10)
hold on
plot(xplot,yplot,'linewidth',2)
hold off

sregg=sum(y1-(a0_coeff+a1_coeff*x1)).^2;
stot=sum(y1-mean(y1)).^2;
rsq=sqrt((stot-sregg)/stot)

%% Problem 2: Polynomial curve fit (50 points)
%
% *2a. (25 points)*
% Modify the function that you wrote for *Problem 1* so that it can perform
% least squares regression to any polynomial curve of a given degree. Fit a
% cubic polynomial to the dataset $(x_{2},y_{2})$ and report the coefficients 
% $a_{0}$, $a_{1}$, $a_{2}$, and $a_{3}$ for the cubic fit 
% $y = a_{0} + a_{1}x + a_{2}x^2 + a_{3}x^3$. Also report the coefficient of 
% determination ($r^2$) for the goodness of fit.
%
% *Answer*
degree = 3;
[a0_coeff,a1_coeff,a2_coeff,a3_coeff,xplot2,yplot2] = polylsr(degree,x2,y2);


%%
% *2b. (25 points)*
% Plot the original data as scatter points and the curve fit or
% approximation on the same figure. Report the coefficient of determination
% ($r^2$) for the goodness of fit.
degree = 3;
[a0_coeff,a1_coeff,a2_coeff,a3_coeff,xplot2,yplot2] = polylsr(degree,x2,y2);

plot(x2,y2,'.','markersize',10)
hold on
plot(xplot2,yplot2,'linewidth',2)
hold off


p = polyfit(x2,y2,1);
k=polyval(p,x1);
a0=p(1);
a1=p(2);

pb=mean(p);
st=sum((p-pb).^2);
srg=sum((k-pb).^2);
srs=sum((p-k).^2);
r2=1-srs/st;
r=corrcoef(x2,y2);
rsquare=r(1,2).^2