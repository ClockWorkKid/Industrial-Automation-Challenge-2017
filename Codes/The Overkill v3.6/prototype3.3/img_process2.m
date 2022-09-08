function [coOrdPixel,shape]=img_process2(cam)

thX = 50;   %%%%%%ALSO CHANGE IN angleCalc.m
thY =40;    %%%%%%ALSO CHANGE IN angleCalc.m
hCam=68.0; %%%%%%ALSO CHANGE IN angleCalc.m

D2R = pi/180;
R2D = 180/pi;

rStandard = 0.6 ;                           
gStandard = 0.55 ;
bStandard = 0.55 ;
dustRemoveRGB = 3;
dustRemoveA = 10; 
HOrientation= 38;
LOrientation= 0;
diff= HOrientation- LOrientation;

while true
transfer=0;

I= snapshot(cam);
imshow(I);
R = I(:,:,1);                        
G = I(:,:,2);                       
B = I(:,:,3);

R = im2bw(R,rStandard);                     
G = im2bw(G,gStandard);
B = im2bw(B,bStandard);
RGB = (R & G & B);
A = imfill(RGB,'holes');
RGB = imcomplement(RGB);
RGB = RGB & A;
RGB = imopen(RGB,strel('disk',dustRemoveRGB));
A = imopen(A,strel('disk',dustRemoveA));

imshow(I);
stats = regionprops(RGB,'BoundingBox','Perimeter','Area','Orientation'...
    ,'Centroid');

statbox = regionprops(A,'BoundingBox','Extent','Centroid','Area');
if ~isempty(statbox)
    sim = statbox.Extent;
    sim = 1/sim;
    sim = sim - 1 ;
    sim=asin(sim);
    sim=0.5*(180/3.1416)*sim;
    sim=((sim-LOrientation)/diff)*45;
    orient = sim;
end



shape = 0;
for i=1:length(statbox)
    hold on;
    tArea=((1280*2*R2D*atan(6/(hCam-12)))/thX)^2;
    aArea= statbox(i).Area;
    percentAreaErr = 100*abs(tArea-aArea)/tArea;
    box = statbox(i).BoundingBox;
    percentHWErr = 100*abs(box(3)-box(4))/box(3);
    if(percentAreaErr<=10)&&(percentHWErr<=15)
        h = rectangle('Position',statbox(i).BoundingBox);
        transfer=i;
        temp=statbox(i).Centroid;
        set(h,'EdgeColor',[0.9,0.9,0.9]);
        break
    end
end
hold on;
if (transfer==0)
    continue
end
for i =1:length(stats)
    box=statbox(transfer).BoundingBox;
    shapeCenter=stats(i).Centroid;
	inBox=(shapeCenter(1)>box(1))&&(shapeCenter(1)<(box(1)+box(3)))...
            &&(shapeCenter(2)>box(2))&&(shapeCenter(2)<(box(2)+box(4)));
    if (inBox == true)
        h = rectangle('Position',stats(i).BoundingBox);
        mask = stats(i).Perimeter^2 / stats(i).Area ; 
        if (mask <14)
            set(h,'EdgeColor',[0.7,0,0]);
            shape=2; %circle
            else
                if (mask < 18)
                    set(h,'EdgeColor',[0,0.7,0]);
                    shape=3; %square
                else
                    set(h,'EdgeColor',[0,0,0.7]);
                    shape=1; %triangle
                end;
            end;
        end;
    end;
    hold off;
    coOrdPixel=temp;
    break
end
end




