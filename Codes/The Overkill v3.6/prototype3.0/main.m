clear all;
clc;

% arena calibrations
hCam = 44.0;
l = 20;     %distance of arm center from belt

%constants
thX = 47.8;
thY = 37.65;    

%user variables
D2R = pi/180;
R2D = 180/pi;

%theta3 variables
x = 2*(hCam-12)*tan(thX/2*D2R); %length of imaginary plane at x axis in cm
y = 2*(hCam-12)*tan(thY/2*D2R); %length of imaginary plane at y axis in cm
d = l + 12*tan(D2R*thY/2); % distance of imaginary plane from arm axis

cam = init_cam();
 a = arduino();
 sShoulderTwist = servo(a, 'D9');
 sShoulder1 = servo(a, 'D7');
 sShoulder2 = servo(a, 'D8');
 sDhoulder3 = servo(a, 'D10');
 sElbow = servo(a, 'D4');
 sGrip = servo(a, 'D3');

 
 I = snapshot(cam);
 pause(2);
 I = snapshot(cam);
    
 cordPix=img_process(I);
    
 X= (640-cordPix(1))*x/1280.0; %cm
 Y= cordPix(2)*y/960.0+ d; %cm
 
 %delta1 calculation
 rtxy=sqrt((X*X+(Y*Y))+(l*l));
 P=R2D*atan(l/sqrt(X*X+(Y*Y)))+R2D*acos(rtxy/60);
 Q=R2D*atan(2/7);
 q=sqrt(153-(cos(D2R*(90-P-Q))*145.602));
 R= R2D*acos((q*q-47)/q*14.56);
 S=R2D*acos(q/10);
 T=90-Q;
 delta1=360-T-R-S;
 
 %delta2 calculation
 C=R2D*acos((1300-(rtxy^2))/1200);
 D=180-C;
 GK = sqrt(500-(cos(D2R*D)*400));
 F= R2D*acos((300+GK*GK)/(40*GK));
 BD = 9.155;
 DL = sqrt(87.41-(79*cos(D2R*delta1)));
 H = 49.874;
 G = R2D*acos((DL*DL+37.41)/(DL*15.8));
 GH=G+H;
 BL = sqrt((DL*DL)+(BD*BD)-2*DL*BD*cos(D2R*GH));
 K = R2D*acos((125-BL*BL)/100);
 II = 180-F-K;
 GL = sqrt((25+(GK*GK)-10*GK*cos(D2R*II)));
 KLG = R2D*acos((GL*GL+25-(GK*GK))/(10*GL));
 J = R2D*acos((BL*BL-75)/(10*BL));
 M = R2D*acos((25+(BL*BL)-(AB*AB))/(10*BL));
 N = 180-delta1-G;
 L = 360-KLG-J-M-N;
 GD = sqrt(GL*GL+(DL*DL)-(2*GL*DL*cos(D2R*L)));
 GDL = R2D*acos((GD*GD+(DL*DL)-(GL*GL))/(2*GD*DL));
 GDF = R2D*acos((GD*GD-875)/(10*GD));
 delta2 = 180-(GDL+GDF+G);
 
 while true
    writePosition(
 end;
 
 





