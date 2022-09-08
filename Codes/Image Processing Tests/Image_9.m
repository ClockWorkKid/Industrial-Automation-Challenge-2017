
clear all; 
%memory clear


%command line clear
clc;        

%reads a photo and saves in 'I' 3D array
I = imread('D:\img (9).jpg'); 

%seperates the 3D matrix into 3 2D matrix containing value of RGB
R = I(:,:,1);                        
G = I(:,:,2);                       
B = I(:,:,3);

%fraction of 255 detemined as for each color
r = 0.6 ;                           
g = 0.55 ;
b = 0.55 ;

%convert the 3 2d matrices into three binary images using reference value 
R = im2bw(R,r);                     
G = im2bw(G,g);
B = im2bw(B,b);

%merge the 3 2D binary images using 'and' operator into a 2D binary image
RGB = (R & G & B);


%IMComplement is a function to convert the image using 'not' operator
%IMFill is a function to 
A = imfill(RGB,'holes');
%figure,imshow(A)
RGB = imcomplement(RGB);
figure,imshow(RGB)
RGB = RGB & A;
%figure,imshow(RGB)
RGB = imopen(RGB,strel('disk',20));
A = imopen(A,strel('disk',50));

% subplot(2,2,1),imshow(RGB);
% subplot(2,2,2),imshow(R);
% subplot(2,2,3),imshow(G);
% subplot(2,2,4),imshow(I);
imshow(I);

%cc = bwconncomp(RGB, 8);
stats = regionprops(RGB,'BoundingBox','Perimeter','Area');

statbox = regionprops(A,'Centroid','BoundingBox','Orientation')

length(stats)
length(statbox)

for i =1:length(stats)
    hold on;
    h = rectangle('Position',stats(i).BoundingBox);
    mask = stats(i).Perimeter^2 / stats(i).Area ; 
    if (mask <14)
        set(h,'EdgeColor',[0.7,0,0]);
    else if (mask < 18)
            set(h,'EdgeColor',[0,0.7,0]);
        else
            set(h,'EdgeColor',[0,0,0.7]);
        end;
    end;
end;

hold on;
h = rectangle('Position',statbox(1).BoundingBox);
set(h,'EdgeColor',[0.9,0.9,0.9]);

hold off;



