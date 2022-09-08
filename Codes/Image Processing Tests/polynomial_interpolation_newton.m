clear all;
clc;

x = [0 1 2 3 4 5 6];
y = [0 .8415 .9093 .1411 -.7568 -.9589 -.2794];


for i=2:7
    for j=i:7
        y(i,j) = (y(i-1,j) - y(i-1,j-1)) / (x(j) -x(j-i+1));
    end      
end

poly = 0;
for i=1:7
    p = 1;
    for j=1:i-1
        p = conv(p, [1 -x(j)]);
    end
    p = p*y(i,i);
    poly = [zeros(1,size(p,2)-size(poly,2)) poly] + [zeros(1,size(poly,2)-size(p,2)) p ] ;
end

X = 0:.01:6 ;
plot(X, polyval(poly,X));
a = polyval(poly,2.5);
display(a);
    