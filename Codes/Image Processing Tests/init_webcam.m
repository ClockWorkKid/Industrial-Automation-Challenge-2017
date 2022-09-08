function cam = init_cam()
cam = webcam('USB Video Device');
 cam.Contrast = 32 ;
% cam.Hue = 1 ;
% cam.Gamma = 105;
 cam.Exposure = -4;
% cam.WhiteBalance = 4500 ;
cam.WhiteBalanceMode= 'auto';
 cam.Sharpness = 24;
 cam.Brightness = 150;
 cam.Resolution = '1280x960';
 cam.Saturation= 32;
 cam.Gain= 192;
 cam.ExposureMode= 'auto';
 cam.BacklightCompensation= 0;
end