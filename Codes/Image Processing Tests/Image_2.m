clear all;
clc;
I = imread('E:\candy.jpg');
Ig = rgb2gray(I);
level = 0.95;
Ithresh = im2bw(I,level);
Ithresh = bwareaopen(imcomplement(Ithresh),300);
imshowpair(Ig,Ithresh,'montage');
cc=bwconncomp(Ithresh,8);
cc.NumObjects