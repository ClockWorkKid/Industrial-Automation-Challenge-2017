function [coOrdPixel,shape]=img_process2(cam)

thX = 50;   %%%%%%ALSO CHANGE IN angleCalc.m
thY =40;    %%%%%%ALSO CHANGE IN angleCalc.m
hCam=56.0; %%%%%%ALSO CHANGE IN angleCalc.m

D2R = pi/180;
R2D = 180/pi;

rStandard = 0.6 ;                           
gStandard = 0.55 ;
bStandard = 0.55 ;
dustRemoveRGB = 10;
dustRemoveA = 5; 
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

R1 = im2bw(R,rStandard);                     
G1 = im2bw(G,gStandard);
B1 = im2bw(B,bStandard);
RGB = (R1 & G1 & B1);
A = imfill(RGB,'holes');
RGB1 = imcomplement(RGB);
RGB2 = RGB1 & A;
RGB3 = imopen(RGB2,strel('disk',dustRemoveRGB));
A1 = imopen(A,strel('disk',dustRemoveA));

subplot(2,2,1),imshow(R1);
subplot(2,2,2),imshow(RGB);
subplot(2,2,3),imshow(RGB3);
subplot(2,2,4),imshow(I);
stats = regionprops(RGB3,'BoundingBox','Perimeter','Area','Orientation'...
    ,'Centroid');

statbox = regionprops(A1,'BoundingBox','Extent','Centroid','Area');
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
    if(percentAreaErr<=20)&&(percentHWErr<=25)
        h = rectangle('Position',statbox(i).BoundingBox);
        transfer=i;
        temp=statbox(i).Centroid;
        set(h,'EdgeColor',[0.9,0.9,0.9]);
        break
    end
end
hold on;
if (transfer==0)
    pause(5);
    
    clear I
     clear RGB
     clear RGB1
     clear RGB2
     clear RGB3
     clear A
     clear A1
     clear R
     clear G
     clear B
     clear R1
     clear G1
     clear B1
     clear stats
    clear statbox
    
    
    
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
    
     clear I
     clear RGB
     clear RGB1
     clear RGB2
     clear RGB3
     clear A
     clear A1
     clear R
     clear G
     clear B
     clear R1
     clear G1
     clear B1
     clear stats
    clear statbox
    break
end
end




