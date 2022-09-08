clear all;
clc;

x =(0:1:10)';
y = sin(x);
xi = (0:10)';
yi = interp1q(x,y,xi);
plot(x,y,'o',