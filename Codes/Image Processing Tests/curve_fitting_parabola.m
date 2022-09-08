clear all;
close all;
clc;

% x = [0 10 12 16 21 23];
% y = [100 123 124 131 140 142];

% y = [27 42 48 60 76 104];
% x = [0 17 27 40 57 83];

x = 0:.5:9.0;
y = [83 81.5 80.5 79.0 77.5 76.1 75.7 74.0 73.0 71.6 70.5 69.5 68.7...
    67.7 67 66 65 64 63];

sumx = 0;
sumx_2 = 0;
sumx_3 = 0;
sumx_4 = 0;
sumy = 0;
sumxy= 0;
sumx_2y = 0;
z = length(x);

for i=1:length(x)
    sumx = sumx + x(i);
    sumx_2 = sumx_2 + x(i)^2;
    sumx_3 = sumx_3 + x(i)^3;
    sumx_4 = sumx_4 + x(i)^4;
    sumy = sumy + y(i);
    sumxy = sumxy + x(i)*y(i);
    sumx_2y = sumx_2y + x(i)*x(i)*y(i);
end

A = [z sumx sumx_2;sumx sumx_2 sumx_3;sumx_2 sumx_3 sumx_4];
B = [sumy;sumxy;sumx_2y];

X = linsolve(A,B);

P = [X(3) X(2) X(1)]; 
plot(x,y,'o')
hold on;

x=0:.1:9;
plot(x,polyval(P,x));
