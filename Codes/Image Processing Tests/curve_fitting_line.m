clear all;
clc;

x = 0:.5:9.0;
y = [83 81.5 80.5 79.0 77.5 76.1 75.7 74.0 73.0 71.6 70.5 69.5 68.7...
    67.7 67 66 65 64 63];

sumx = 0;
sumy = 0;
sumxy= 0;
sumxsq=0;
z = length(x);
for i=1:19 
    sumx = sumx + x(i);
    sumy = sumy + y(i);
    sumxy= sumxy+ x(i)*y(i);
    sumxsq=sumxsq +x(i)*x(i);
end

format long;

a1 = (z*sumxy-sumx*sumy)/(z*sumxsq-sumx*sumx);
a0 = sumy/z-a1*sumx/z;

plot(x,y,'o')
hold on;

ym = a0 + a1*x ;
plot(x,ym);
