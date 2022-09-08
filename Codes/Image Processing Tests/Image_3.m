clear all;
clc;

I = imread('E:\candy.jpg');
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);



r = 0.8;
g = 0.8;
b = 0.8;

Ra = im2bw(R,r);
Ga = im2bw(G,g);
Ba = im2bw(B,b);
RGB = (Ra & Ga & Ba);
RGB = imfill(imcomplement(RGB),'holes');
RGB = imopen(RGB,strel('disk',10));

[label,numobjects]=bwlabel(RGB,4);
stats = regionprops(label,'Eccentricity','Area','BoundingBox');
area = [stats.Area];
eccentricity = stats.Eccentricity;

imshow(RGB);

idxofSkittles = find(eccentricity);
statsDefect = stats(idxofSkittles);
for idx =1:length(idxofSkittles)
    h = rectangle('Position',statsDefect(idx).BoundingBox);
    set(h,'EdgeColor',[0.75,0,0]);
    hold on;
end;