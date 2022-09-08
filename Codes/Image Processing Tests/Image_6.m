clear all;

clc;

I = imread('E:\circle.png');
bw = imbinarize(rgb2gray((I)));
bw = imopen(bw,strel('disk',10));

stats = regionprops('table',bw,'Centroid',...
    'Eccentricity','MajorAxisLength','MinorAxisLength','BoundingBox');
stats.BoundingBox
centers = stats.Centroid;
radii = mean([stats.MajorAxisLength stats.MinorAxisLength],2) / 2;

imshow(bw);
hold on
viscircles(centers,radii);
hold off


