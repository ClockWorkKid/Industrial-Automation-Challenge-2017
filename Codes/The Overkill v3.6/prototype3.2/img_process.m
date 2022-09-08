function [coOrdPixel,shape, orient]=img_process(I)

%fraction of 255 detemined as for each color
rStandard = 0.6 ;                           
gStandard = 0.55 ;
bStandard = 0.55 ;
dustRemoveRGB = 3;
dustRemoveA = 10; 
HOrientation= 38;
LOrientation= 0;
diff= HOrientation- LOrientation;


%seperates the 3D matrix into 3 2D matrix containing value of RGB
R = I(:,:,1);                        
G = I(:,:,2);                       
B = I(:,:,3);


%convert the 3 2d matrices into three binary images using reference value 
R = im2bw(R,rStandard);                     
G = im2bw(G,gStandard);
B = im2bw(B,bStandard);

%merge the 3 2D binary images using 'and' operator into a 2D binary image
RGB = (R & G & B);




%IMComplement is a function to convert the image using 'not' operator
%IMFill is a function to 
A = imfill(RGB,'holes');
RGB = imcomplement(RGB);
RGB = RGB & A;
RGB = imopen(RGB,strel('disk',dustRemoveRGB));
A = imopen(A,strel('disk',dustRemoveA));
imshow(A)
 

stats = regionprops(RGB,'BoundingBox','Perimeter','Area','Orientation');

statbox = regionprops(A,'BoundingBox','Extent','Centroid');
temp=statbox.Centroid;
%statbox.BoundingBox(3)
if ~isempty(statbox)
    sim = statbox.Extent;
    sim = 1/sim;
    sim = sim - 1 ;
    sim=asin(sim);
    sim=0.5*(180/3.1416)*sim;
    sim=((sim-LOrientation)/diff)*45;
    orient = sim;
end

% degree=sim;
imshow(RGB)
imshow(I)
shape = 0;
for i =1:length(stats)
    hold on;
    h = rectangle('Position',stats(i).BoundingBox);
    mask = stats(i).Perimeter^2 / stats(i).Area ; 
    if (mask <14)
        set(h,'EdgeColor',[0.7,0,0]);
        shape=2; %circle
    else if (mask < 18)
            set(h,'EdgeColor',[0,0.7,0]);
            shape=3; %square
        else
            set(h,'EdgeColor',[0,0,0.7]);
            shape=1; %triangle
        end;
    end;
end;

hold on;
h = rectangle('Position',statbox(1).BoundingBox);
set(h,'EdgeColor',[0.9,0.9,0.9]);

hold off;
coOrdPixel=temp;





