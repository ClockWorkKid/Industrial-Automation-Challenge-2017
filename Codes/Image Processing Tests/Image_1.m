clear all;
close all;
clc;
I = imread('E:\cap.jpg');
Mask = imopen(I,strel('disk',50));
R = Mask(:,:,1);
G = Mask(:,:,2);
B = Mask(:,:,3);
New = (imbinarize(imcomplement((imadjust(B+G)+imadjust(imcomplement(R))))));
cc = bwconncomp(New, 4);

grain = false(size(New));
grain(cc.PixelIdxList{1}) = true;
imshow(grain);

graindata = regionprops(cc,'basic');
graindata(1).Area