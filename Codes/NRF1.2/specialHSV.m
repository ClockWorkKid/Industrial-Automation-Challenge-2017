%Read image
imghsv=imread('D:\Drive\Documents\RoboticsTeam\MAHATHIR\NRF1.2\candy.jpg');
imghsv=rgb2hsv(im2double(imghsv));

%pick yellow
yellowIndex=repmat((imghsv(:,:,1)>45/360)&(imghsv(:,:,1)<60/360),[1 1 3]);   
yellow=imghsv.*yellowIndex;
% 
% %Saturate it
moreSaturation=2;
yellowsaturated=yellow(:,:,2)*moreSaturation;
yellow(:,:,2)=yellowsaturated;

% %put it back
newHsv=imghsv; 
newHsv(yellowIndex)=yellow(yellowIndex);
imshow(yellow);
