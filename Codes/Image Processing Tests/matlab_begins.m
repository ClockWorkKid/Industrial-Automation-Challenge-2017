clear all;
clc;

x = [0 1 2 3 4 5];
y = [2.1 7.7 13.6 27.2 40.9 61.1];

sumx = 0;
sumx_2 = 0;
sumx_3 = 0;
sumx_4 = 0;
sumy = 0;
sumxy= 0;
sumx_2y = 0;

for i=1:6
    sumx = sumx + x(i);
    sumx_2 = sumx_2 + x(i)^2;
    sumx_3 = sumx_3 + x(i)^3;
    sumx_4 = sumx_4 + x(i)^4;
    sumy = sumy + y(i);
    sumxy = sumxy + x(i)*y(i);
    sumx_2y = sumx_2y + x(i)*x(i)*y(i);
end

A = [6 sumx sumx_2;sumx sumx_2 sumx_3;sumx_2 sumx_3 sumx_4];
B = [sumy;sumxy;sumx_2y];

X = linsolve(A,B);

P = [X(3) X(2) X(1)]; 
plot(x,y,'o')
hold on;

x=0:.1:6;
plot(x,polyval(P,x));
