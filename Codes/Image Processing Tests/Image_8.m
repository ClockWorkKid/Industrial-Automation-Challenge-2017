clear all;
clc;

I = imread('D:\candy.jpg');
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

r = 0.75 ; 
g = 0.1 ;
b = 0.5 ;

R = im2bw(R,r);
G = imcomplement(im2bw(G,g));
RGB = (R | G );
RGB = imfill(RGB,'holes');
RGB = imopen(RGB,strel('disk',50));

%cc = bwconncomp(RGB, 8);
stats = regionprops(RGB,'Centroid',...
    'Eccentricity','MajorAxisLength','MinorAxisLength','BoundingBox');
subplot(2,2,1),imshow(RGB);
subplot(2,2,2),imshow(R);
subplot(2,2,3),imshow(G);
subplot(2,2,4),imshow(I);


for i =1:length(stats)
    h = rectangle('Position',stats(i).BoundingBox);
    set(h,'EdgeColor',[0.75,0,0]); hold on;
end;
hold off;


% centers = stats.Centroid;
% radii = mean([stats.MajorAxisLength stats.MinorAxisLength],2) / 2;
% hold on 
% viscircles(centers,radii);
% hold off;



