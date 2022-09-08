clear all;
clc;

cam = init_cam2();%IMPORTANT
a=arduino();%IMPORTANT

%sMotor = MServo(arduino,pin,tuning,TAngle,AAngle)
sTwist = MServo(a,'D7',-75,250,250);%IMPORTANT
sShoulder = MServoTrio(a,'D3','D4','D5',0,0,0,180,165);%IMPORTANT
sElbow = MServo(a,'D6',10,180,165);%IMPORTANT
sGripTwist = MServo(a,'D9',10,180,165);%IMPORTANT
sGrip = MServo(a,'D8',0,180,165);%IMPORTANT

%%%%%%%INITIALIZATION%%%%%%
sTwist.MWrite(270);
sShoulder.MWrite(0);
sElbow.MWrite(45);
sGrip.MWrite(10);
sGripTwist.MWrite(90);

 while true
    disp('Reboot');
    sTwist.MWrite(180);
    sShoulder.MWrite(0);
    sElbow.MWrite(45);
    sGrip.MWrite(10);
    sGripTwist.MWrite(90);
     [cordPix,shape]=confirmBox(cam)
     
     [delta1,delta2,theta3,confirmation]=confirmAngle(cordPix, 15)
     if ~confirmation
          if delta1<0
              delta1=0;
              delta2=60;
          
              
          else
              clearvars -except cam a sTwist sShoulder sElbow ...
                  sGripTwist sGrip
              
              
               continue; 
          end
            
     end
        disp('1');
       %ADJUSTMENTS%
       theta3=theta3+2;

       %%%%OBJECT DETECTED AND MOVE TO READY POSITION%%%%%
       sTwist.MWrite(180);
       sShoulder.MWrite(0);
       sElbow.MWriteTime(45,0,0.5);
       sGrip.MWrite(10);
       sGripTwist.MWrite(90);
       pause(1);
       
       %%%%%MOVE ABOVE OBJECT%%%%%
       sTwist.MWriteTime(180,theta3,0.5);
       sShoulder.MWriteTime(0,delta1,1);
       sElbow.MWriteTime(0,delta2,1);
       sGripTwist.MWriteTime(90,theta3,1);
       
       %%%%%PREPARE FOR GRIP%%%%%
       [delta11,delta22,theta33,confirmation]=confirmAngle(cordPix, 12)
       if delta11<0
           delta11=10;
           delta22=90;
       end
       
       disp('2');
       
       
       
%        if delta1==delta11
%            sShoulder.MWrite(delta11);
%        else
       sShoulder.MWriteTime(delta1,delta11,1);
%        end
       
       sElbow.MWriteTime(delta2,delta22,1);
       
       %%%%%%GRIP AND PREPARE FOR ROTATE
       sGrip.MWriteTime(10,60,1);
       sElbow.MWriteTime(delta22,0,1);
       sShoulder.MWriteTime(delta11,0,1);
       sElbow.MWriteTime(0,30,1);
       pause(0.5);
       %%%%%%MOVE ABOVE DESTINATION AND PREPARE FOR DROP
       X=30; %%%%%%%%
       Y=30;%%%%%%%
       theta5=45;%%%%%%%%%
       if shape==1
            theta4=240;
       end
       if shape==2
           X=0;%%%%%%%%%
           theta5=90;%%%%%%%%%%%%%
           theta4=280;
       end
       if shape==3
          theta4=320;
       end
       disp('4');
       sTwist.MWriteTime(theta3,theta4,1);
       pause(1);
       
       
       %%%%%%RELEASE AND RETURN TO INITIAL POSITION
       
       
       
       
           %%%%%%%%
       
       if shape~=2
           [delta111,delta222]=angleCalcLast(X,Y,20)%%%%%%%%%
           sElbow.MWriteTime(30,delta222,1);%%%%%%%
           %pause(0.1); 
            sShoulder.MWriteTime(0,delta111,1);%%%%%%%%%%%%%%%%
            %pause(0.1);%%%%%%%
       else 
           delta222=30;
       end
       
       disp('6');
       
       sGripTwist.MWriteTime(theta3,theta5,1);%%%%%%%%
       %pause(1);%%%%%%%%%%%
       
       
       
       sGrip.MWrite(10);
       pause(0.5);
       
       sTwist.MWriteTime(theta4,180,1);
       pause(1);
       
       sElbow.MWriteTime(delta222,45,1);%%%%%%%%%%%
       
       if shape~=2
            sShoulder.MWriteTime(delta111,0,1); %%%%%%%%%%%%
       end
       
       %sGripTwist.MWriteTime(theta5,90,1); %%%%%%%%%%%
       
       clearvars -except cam a sTwist sShoulder sElbow sGripTwist sGrip
       
 end
 
 





