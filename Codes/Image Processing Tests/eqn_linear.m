clear all;
clc;

A = [17 2 3 4; 5 6 7 8 ; 9 10 11 12 ; 13 14 15 16 ];
B = [4;3;2;1];
X = linsolve(A,B)
%X = A\B;
%X = pinv(A)*B; %more accurate