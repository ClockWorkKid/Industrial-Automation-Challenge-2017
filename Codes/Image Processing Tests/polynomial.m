clear all;
clc;

A=[3 2 -4];
B=[2 0 0 -2];
C=conv(A,B)
y = roots(C)
x = -20:.1:20;
plot(x,polyval(A,x));