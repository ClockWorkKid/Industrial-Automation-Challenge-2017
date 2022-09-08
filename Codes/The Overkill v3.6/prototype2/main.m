clear all;
clc;

% arena calibrations
hCam = 44.0;
l = 20;     %distance of arm center from belt

%constants
thX = 47.8;
thY = 37.65;
Humerous = 28; %cm
Ulna = 22.5; %cm
Wrist = 20; %cm

%user variables
D2R = 3.14159/180;
R2D = 180/3.14159;

%theta3 variables
x = 2*(hCam-12)*tan(thX/2*D2R); %length of imaginary plane at x axis in cm
y = 2*(hCam-12)*tan(thY/2*D2R); %length of imaginary plane at y axis in cm
d = l + 12*tan(D2R*thY/2); % distance of imaginary plane from arm axis

%servo angles
th1=0.0;
th2=0.0;
th3=0.0;


cam = init_cam();
 a = arduino();
 sShoulderTwist = servo(a, 'D9');
 sShoulder1 = servo(a, 'D7');
 sShoulder2 = servo(a, 'D8');
 sElbow = servo(a, 'D4');
 sGrip = servo(a, 'D3');
 
 writePosition(sShoulderTwist,(180-30)/180.0);
 writePosition(sShoulder1,(200-45)/180.0);
 writePosition(sShoulder2,(200-45)/180.0);
 writePosition(sElbow,(210-57)/180.0);
 writePosition(sGrip,0/180.0);
 
%  pause(10);
 for i=0:1:10
     writeDigitalPin(a, 'D13', 1);
     pause(0.5);
     writeDigitalPin(a, 'D13', 0);
     pause(0.5);
 end;
 
 
 
 
 

    I = snapshot(cam);
    pause(2);
    I = snapshot(cam);
    
    
    cordPix=img_process(I);

    X= (640-cordPix(1))*x/1280.0; %cm
    Y= cordPix(2)*y/960.0+ d; %cm
    
    %theta3 calculations
    th3 = 90-(R2D*atan(X/Y))
    
    %theta2 calcualtions
    da=sqrt((X*X)+(Y*Y));
    cc=sqrt((Wrist*Wrist)+(X*X+Y*Y));
    th21=R2D*atan(Wrist/da);
    th22=R2D*acos((Humerous^2+cc^2-Ulna^2)/(2*Humerous*cc));
    
    th2=th22+th21
   
    %theta1 calculations
    th1=R2D*acos((Ulna^2+Humerous^2-cc^2)/(2*Ulna*Humerous))

for i=45:1:th2
     writePosition(sShoulder1,(200-i)/180.0);
     writePosition(sShoulder2,(200-i)/180.0);
     pause(.02);
     
 end; 
 
 
 
 for i=57:1:th1
    writePosition(sElbow,(210-i)/180.0);
    pause(.02);
end;

pause(1);

for i=180:-1:th3
    writePosition(sShoulderTwist,(i-30)/180.0);
    pause(.01);
end;

Wrist=10;
cc=sqrt((Wrist*Wrist)+(X*X+Y*Y));
th21=R2D*atan(Wrist/da);
th22=R2D*acos((Humerous^2+cc^2-Ulna^2)/(2*Humerous*cc));
    
th2p=th22+th21
th1p=R2D*acos((Ulna^2+Humerous^2-cc^2)/(2*Ulna*Humerous))


while ((th2>th2p) || (th1>th1p) )
    if th2 > th2p
    th2= th2-0.1;
    writePosition(sShoulder1,(200-th2)/180.0);
    writePosition(sShoulder2,(200-th2)/180.0);
    
    end;
    if th1 > th1p
    th1= th1-0.1;
    writePosition(sElbow,(210-th1)/180.0);
    end;

    pause(.01);
    
end;

writePosition(sGrip,55/180.0);

while ((th1>=70)||(th2<=80))
    if(th1>=70)
        writePosition(sElbow,(210-th1)/180.0);
        th1=th1-0.2;
    end;
    if(th2<=80)
        writePosition(sShoulder1,(200-th2)/180.0);
        writePosition(sShoulder2,(200-th2)/180.0);
        th2=th2+0.2;
    end;
    pause(.03);
end;

for th3=th3:1:180
    writePosition(sShoulderTwist,(th3-30)/180.0);
    pause(.1);
end;


   
 while true  
 writePosition(sShoulderTwist,(th3-30)/180.0);
 writePosition(sShoulder1,(200-th2)/180.0);
 writePosition(sShoulder2,(200-th2)/180.0);
 writePosition(sElbow,(210-th1)/180.0);
 writePosition(sGrip,0/180.0);
 
 end;






