clear all;
clc;

cam = init_cam();
% a = arduino();
% s = servo(a, 'D4');
for (i=1:1:1000)
    I = snapshot(cam);
    degree=img_process(I);
%     writePosition(s,degree);
end;
clear all;




