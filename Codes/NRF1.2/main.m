clear all;
cam = init_cam2();

% I= snapshot(cam);
% pause(1);
% I= snapshot(cam);
% imshow(I);
I=imread('C:\Users\Shuvo\Google Drive\RoboticsTeam\SHUVO\NRF1.2\cap.jpg');
centroidArray = segmentation(I,"red");
figure,imshow(I);
if isempty(centroidArray)
 centroidArray = "NULL"
else
for i=1:length(centroidArray)
centroidArray(i).Centroid
end
end

