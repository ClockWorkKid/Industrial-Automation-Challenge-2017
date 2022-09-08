clear all;
clc;

x =(0:6)';
y = [ 0 .8415 .9093 .1411 -.7568 -.9589 -.2794]';
xi = (0:.5:6)' ;
yi = interp1q(x,y,xi);
plot(x,y,'o',xi,yi);

y1 = interp1q(x,y,2.5) %show value at query point 2.5