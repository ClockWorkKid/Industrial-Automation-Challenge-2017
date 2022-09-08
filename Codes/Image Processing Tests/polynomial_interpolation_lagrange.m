clear all;
close all;
clc;

x = [0 10 12 16 21 23];
y = [100 123 124 131 140 142];
% y = [27 42 48 60 76 104];
% x = [0 17 27 40 57 83];
poly = [0];
for i=1:length(x)
    P = [1] ;
    for j=1:length(x)
        if j~= i
            P = conv(P,[1 -(x(j))])/(x(i) - (x(j)));
        end
    end
        poly = poly + P*y(i) ;
end

X = 0:.01:23 ;
plot(x,y,'o');
hold on;
plot(X, polyval(poly,X));
hold off;

a = polyval(poly,2.5);
display(a);