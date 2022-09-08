clear all;
clc;

cam = init_cam();
a = arduino();
sShoulderTwist = servo(a, 'D9');
sShoulder1 = servo(a, 'D4');
sShoulder2 = servo(a, 'D5');
sShoulder3 = servo(a, 'D6');
sElbow = servo(a, 'D8');
sGrip = servo(a, 'D12');
sGripTwist = servo(a, 'D13');

 
 I= snapshot(cam);
 pause(2);
 I = snapshot(cam);
    
 [cordPix,shape, orient]=img_process(I);
 [delta1,delta2,theta3,theta4]=angleCalc(cordPix, orient, 20);
 
   sShoulderTwistAngle= 180;
   sShoulderAngle =0 ;
   sElbowAngle = 20;
   sGripAngle= 10;
   sGripTwistAngle=90;
  
  
    
  writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
  writePosition(sShoulder1 , sShoulderAngle*(165/180)/180 );
  writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
  writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
  writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
  writePosition(sGrip , sGripAngle*(165/180)/180);
  writePosition(sGripTwist , (sGripTwistAngle+17)*(165/180)/180);
  
  
  pause(5);
%   
%   for sShoulderTwistAngle=sShoulderTwistAngle:-1:theta3
%       writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
%       pause(0.03);
%   end;
%   servoRun(s,firstA,finalA,init0,AchieveA,ExpectedA,delay)
   
    sRun(sShoulderTwist,1,sShoulderTwistAngle,theta3,-78,2);
    sShoulderTwistAngle = theta3;
    
    
    sRun(sGripTwist,0,sGripTwistAngle,theta3,17,1);
    sGripTwistAngle=theta3;
  
    
     sRun3(sShoulder1,sShoulder2,sShoulder3,sShoulderAngle,delta1,0);
     sShoulderAngle= delta1;


    sRun(sElbow,2,sElbowAngle,delta2,14,0);
    sElbowAngle= delta2;
    
    [delta1,delta2,theta3,theta4]=angleCalc(cordPix, orient,12);
    
    while( sShoulderAngle<=delta1 ||sElbowAngle<=delta2 )
        
        if sShoulderAngle<=delta1
            writePosition(sShoulder1,(sShoulderAngle*165)/(180*180));
            writePosition(sShoulder2,(sShoulderAngle*165)/(180*180));
            writePosition(sShoulder3,(sShoulderAngle*165)/(180*180));
            sShoulderAngle=sShoulderAngle+1;
        end
        if sElbowAngle<=delta2
            writePosition(sElbow,((sElbowAngle+14)*165)/(180*180));
            sElbowAngle= sElbowAngle +1;
        end;
        pause(.05);
    end
    
    sRun(sGrip,0,sGripAngle,57,0,1);
    sGripAngle = 57;
    
    sRun(sElbow,2,sElbowAngle,0,14,1);
    sElbowAngle= 0;
    
    for sShoulderAngle=sShoulderAngle:-1:0
        writePosition(sShoulder1,(sShoulderAngle*165)/(180*180));
        writePosition(sShoulder2,(sShoulderAngle*165)/(180*180));
        writePosition(sShoulder3,(sShoulderAngle*165)/(180*180));
        pause(.02);
    end;
    
    sRun(sElbow,2,sElbowAngle,25,14,1);
    sElbowAngle= 25;
    
    
    if shape == 1
        theta5 = 225+20;
    end;
    if shape == 2
        theta5 = 270+20;
    end;
    if shape == 3
        theta5 = 315;
    end;
    
    sRun(sShoulderTwist,1,sShoulderTwistAngle,theta5,-78,0);
    sShoulderTwistAngle = theta5;
    
    pause(0.5);
    
    sRun(sGrip,0,sGripAngle,10,0,0);
    sGripAngle = 10;
    
    sRun(sShoulderTwist,1,sShoulderTwistAngle,180,-78,1);
    sShoulderTwistAngle = 180;
    
    
    
    
    

    
    
    
    
  
 
 while true
    writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
    writePosition(sShoulder1 , sShoulderAngle*(165/180)/180);
    writePosition(sShoulder2 , sShoulderAngle*(165/180)/180);
    writePosition(sShoulder3 , sShoulderAngle*(165/180)/180);
    writePosition(sElbow , (sElbowAngle+14)*(165/180)/180);
    writePosition(sGrip , sGripAngle*(165/180)/180);
    writePosition(sGripTwist , (sGripTwistAngle+17)*(165/180)/180);
  
 end;
 
 





