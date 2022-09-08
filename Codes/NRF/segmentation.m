redThreshold=10;
greenThreshold=10;
blueThreshold=10;
dustRemove=2;
moreSaturation=2;
color='blue';



redFlag= false; 
if strcmp(color,'red')
    redFlag= true;
    hueLowerLimit=1;
    hueUpperLimit=14;
 elseif strcmp(color,'blue')
     hueLowerLimit=175;
     hueUpperLimit=245;
 elseif strcmp(color,'green')
     hueLowerLimit=75;
     hueUpperLimit=165;
 elseif strcmp(color,'orange')
     hueLowerLimit=15;
     hueUpperLimit=51;
 elseif strcmp(color,'yellow')
     hueLowerLimit=52;
     hueUpperLimit=74;
     
end

 


%red hue 1-10 1-14
%blue hue 215-245 175-245
%green hue 75-140 61-165 75-165
%yellow hue 45-60 52-74
%orange/brown hue       15-51


Im = imread('E:\Drive\Documents\RoboticsTeam\MAHATHIR\NRF\candy2.jpg');

Im=im2double(Im);
[imageRow,imageColumn,p]=size(Im);

imR=squeeze(Im(:,:,1));
imG=squeeze(Im(:,:,2));
imB=squeeze(Im(:,:,3));

imBinaryR= imbinarize(imR,redThreshold/255);
imBinaryG= imbinarize(imG,greenThreshold/255);
imBinaryB= imbinarize(imB,blueThreshold/255);
% imBinaryR= imbinarize(imR,graythresh(imR));
% imBinaryG= imbinarize(imG,graythresh(imG));
% imBinaryB= imbinarize(imB,graythresh(imB));

imBinary=(imBinaryR & imBinaryG & imBinaryB);

imClean=imopen(imBinary,strel('disk',dustRemove));
imClean = imfill(imClean, 'holes');
imClean = imclearborder(imClean);

[labels, numLabels]=bwlabel(imClean);
disp(['Number of objects: ' num2str(numLabels)]);

rLabel=zeros(imageRow,imageColumn);
gLabel=zeros(imageRow,imageColumn);
bLabel=zeros(imageRow,imageColumn);

 for i=1:numLabels
     rLabel(labels==i) = median(imR(labels==i));
     gLabel(labels==i) = median(imG(labels==i));
     bLabel(labels==i) = median(imB(labels==i));
       
 end

imLabel = cat(3,rLabel,gLabel,bLabel);
figure,imshow(imLabel);
imghsv=rgb2hsv(imLabel);

%pick color
Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
     &(imghsv(:,:,1)<=hueUpperLimit/360)));
 
if redFlag==true 
    Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
     &(imghsv(:,:,1)<=hueUpperLimit/360))...
     |((imghsv(:,:,1)<=359/360)&(imghsv(:,:,1)>=347/360)));
end
% Index=((imghsv(:,:,1)>=hueLowerLimit/360)...
%      &(imghsv(:,:,1)<=hueUpperLimit/360));
 

% Index=repmat((imghsv(:,:,1)>hueLowerLimit/360)...
%     &(imghsv(:,:,1)<hueUpperLimit/360),[1 1 3]);   
%color=imghsv.*Index;

% %Saturate it

%colorSaturated=color(:,:,2)*moreSaturation;
%color(:,:,2)=colorSaturated;

% %put it back
%newHsv=imghsv; 
%newHsv(Index)=color(Index);
figure,imshow(Index);

