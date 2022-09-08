clear all;
clc;

I = imread('E:\cap.jpg');
R = I(:,:,1);

r = 0.85;

RGB = im2bw(R,r);

RGB = imfill(RGB,'holes');
RGB = imopen(RGB,strel('disk',10));
data = bwconncomp(RGB,8);
imshow(RGB);

%imshow(RGB);
data.NumObjects
areadata = regionprops(data, 'basic');
areadata(1).Area