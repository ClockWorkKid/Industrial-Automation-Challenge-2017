clear all;
clc;

% arena calibrations
hCam = 60.0;
l = 15;     %distance of arm center from belt

%constants
thX = 47.8;
thY = 37.65;  


%user variables
D2R = pi/180;
R2D = 180/pi;

%arm variable
a1 = 30;
b1 = 10;
c1 = 25;
d1 = 5;

%theta3 variables
x = 2*(hCam-12)*tan(thX/2*D2R); %length of imaginary plane at x axis in cm
y = 2*(hCam-12)*tan(thY/2*D2R); %length of imaginary plane at y axis in cm
d = l + 12*tan(D2R*thY/2); % distance of imaginary plane from arm axis

 cam = init_cam();
 a = arduino();
 sShoulderTwist = servo(a, 'D9');
 sShoulder1 = servo(a, 'D4');
 sShoulder2 = servo(a, 'D5');
 sShoulder3 = servo(a, 'D6');
 sElbow = servo(a, 'D8');
%  sGrip = servo(a, 'D3');

 
 I = snapshot(cam);
 pause(2);
 I = snapshot(cam);
    
 [cordPix,shape, orient]=img_process(I);
    
 X= (640-cordPix(1))*x/1280.0 %cm
 Y= cordPix(2)*y/960.0+ d %cm
 theta4 = orient
 
% X= 0.7680;
% Y= 32.3654;
 sqrt(X*X+(Y*Y));
 %delta1 calculation
 rtxy=sqrt((X*X+(Y*Y))+(l*l));
 temp=(rtxy*rtxy+900-(a1*a1))/(60*rtxy);
 
 P=R2D*atan(l/sqrt(X*X+(Y*Y)))+R2D*acos(rtxy/60);
 Q=R2D*atan(2/7);
 q=sqrt(153-(cos(D2R*(90-P-Q))*145.602));
 
 %CHANGED!!!
 %R= R2D*acos((q*q-47)/(q*14.56)));
 
 T=90-Q;
 R= R2D*acos((q*q-47)/(q*14.56));
 if P>T
     R=360-R;
 end;
 
 S=R2D*acos(q/10);
 
 delta1=360-T-R-S
 
 %delta2 calculation
 C=R2D*acos((900+(a1*a1)-(rtxy*rtxy))/(60*a1));
 D=180-C;
 GK = sqrt(400+(b1*b1)-(cos(D2R*D)*40*b1));
 F= R2D*acos((400-(b1*b1)+(GK*GK))/(40*GK));
 BD = 9.155;
 DL = sqrt(87.41-(79*cos(D2R*delta1)));
 H = 49.874;
 G = R2D*acos((DL*DL+37.41)/(DL*15.8));
 GH=G+H;
 BL = sqrt((DL*DL)+(BD*BD)-2*DL*BD*cos(D2R*GH));
 K = R2D*acos((125-BL*BL)/100);
 II = 180-F-K;
 GL = sqrt((25+(GK*GK)-(10*GK*cos(D2R*II))));
 KLG = R2D*acos((GL*GL+25-(GK*GK))/(10*GL));
 J = R2D*acos((BL*BL-75)/(10*BL));
 AB= 7.280;
 M = R2D*acos((25+(BL*BL)-(AB*AB))/(10*BL));
 N = 180-delta1-G;
 
 %%%%%%%L = 360-KLG-J-M-N; %%%%%%%%%%%%%%%%
 L=360-KLG-(J-M)-N;
 
 GD = sqrt(GL*GL+(DL*DL)-(2*GL*DL*cos(D2R*L))); 
 GDL = R2D*acos((GD*GD+(DL*DL)-(GL*GL))/(2*GD*DL)); 
 GDF = R2D*acos((GD*GD+(d1*d1)-(c1*c1))/(2*d1*GD)); 
 delta2 = 180-(GDL+GDF+G)
 
 theta3 = 90 - R2D*atan(X/Y)
 
 
  sShoulderTwistAngle= 180;
  sShoulderAngle =0 ;
  sElbowAngle = 0;
  
  
    
  writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
  writePosition(sShoulder1 , sShoulderAngle*(165/180)/180 );
  writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
  writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
  writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
  
  for i=1:1:10
  writeDigitalPin(a, 'D13' , 1 );
  pause(.5);
  writeDigitalPin(a, 'D13' , 0 );
  pause(.5);
  end;
  
  
  for sShoulderTwistAngle=sShoulderTwistAngle:-1:theta3
      writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
      pause(0.03);
  end;
  
  for sShoulderAngle=sShoulderAngle:1:delta1
      writePosition(sShoulder1 , sShoulderAngle*(165/180)/180 );
      writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
      writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
      pause(.05);
  end;
    
  for sElbowAngle=sElbowAngle:1:delta2
      writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
      pause(0.05);
  end;
  
  pause(3);
  
 for sElbowAngle=sElbowAngle:-1:0
      writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
      pause(0.05);
 end;
 
 for sShoulderAngle=sShoulderAngle:-1:0
      writePosition(sShoulder1 , sShoulderAngle*(165/180)/180);
      writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
      writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
      pause(.05);
 end;
  
 if (shape == 1) 
 for sShoulderTwistAngle=sShoulderTwistAngle:1:225
      writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
      pause(0.03);
 end;
 end;
 
 if (shape == 2) 
 for sShoulderTwistAngle=sShoulderTwistAngle:1:270
      writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
      pause(0.03);
 end;
 end;
 
 if (shape == 3) 
 for sShoulderTwistAngle=sShoulderTwistAngle:1:315
      writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
      pause(0.03);
 end;
 end;
 
 pause(3);
 
  for sShoulderTwistAngle=sShoulderTwistAngle:-1:180
      writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
      pause(0.03);
  end;
 
 
  
 disp(shape)
 
 
 
  
 while true
    writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
    writePosition(sShoulder1 , sShoulderAngle*(165/180)/180);
    writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
    writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
    writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
 end;
 
 





