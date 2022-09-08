clear all;

clc;

I = imread('D:\candy.jpg');
R = I(:,:,1);

r = 0.85;

RGB = im2bw(R,r);
RGB = imfill(RGB,'holes');
RGB = imopen(RGB,strel('disk',10));


stats = regionprops('table',RGB,'Centroid',...
    'Eccentricity','MajorAxisLength','MinorAxisLength')

centers = stats.Centroid;
radii = mean([stats.MajorAxisLength stats.MinorAxisLength],2) / 2;

imshow(I);
hold on
viscircles(centers,radii);
hold off



