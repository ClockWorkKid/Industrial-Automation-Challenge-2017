clear all;
clc;

I = imread('E:\cap.jpg');
R = I(:,:,1);

r = 0.85;

RGB = im2bw(R,r);
RGB = imfill(RGB,'holes');
RGB = imopen(RGB,strel('disk',10));



%data = regionprops(RGB, 'centroid');
[label,numobjects]=bwlabel(RGB,4);
stats = regionprops(label,'Eccentricity','Area','BoundingBox');
%?stats = labelmatrix(stats);
area = [stats.Area];
eccentricity = stats.Eccentricity;

subplot(1,2,1),imshow(RGB);
subplot(1,2,2),imshow(I);
idxofSkittles = find(eccentricity);
statsDefect = stats(idxofSkittles);
for idx =1:length(idxofSkittles)
    h = rectangle('Position',statsDefect(idx).BoundingBox);
    set(h,'EdgeColor',[0.75,0,0]);
    hold on;
end;


