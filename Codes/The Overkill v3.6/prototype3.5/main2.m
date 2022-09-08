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
disp('INITIALIZATION');
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
          if (delta1<0)||(theta3<75)
              if delta1<0
              delta1=0;
              delta2=60;
              end
              if theta3<76
                  theta3=76;
              end
              
          else

               continue; 
          end
            
     end
       
       %ADJUSTMENTS%
       theta3=theta3+6;

       %%%%OBJECT DETECTED AND MOVE TO READY POSITION%%%%%
       disp('OBJECT DETECTED AND MOVE TO READY POSITION');
       sTwist.MWrite(180);
       sShoulder.MWrite(0);
       sElbow.MWriteTime(45,0,0.5);
       sGrip.MWrite(10);
       sGripTwist.MWrite(90);
       pause(1);
       
       
       
       %%%%%MOVE ABOVE OBJECT%%%%%
       disp('MOVE ABOVE OBJECT');
       sTwist.MWriteTime(180,theta3,0.5);
       sShoulder.MWriteTime(0,delta1,0.5);
       sElbow.MWriteTime(0,delta2,0.5);
       sGripTwist.MWriteTime(90,theta3,0.5);
       
        
       
       %%%%%PREPARE FOR GRIP%%%%%
       disp('PREPARE FOR GRIP');
       [delta11,delta22,theta33,confirmation]=confirmAngle(cordPix, 11)
       if delta11<0
           delta11=10;
           delta22=90;
       end
       if theta33<76
          theta33=76 ;
       end
       
       
       
       
       
%        if delta1==delta11
%            sShoulder.MWrite(delta11);
%        else
       sShoulder.MWriteTime(delta1,delta11,0.5);
%        end
       
       sElbow.MWriteTime(delta2,delta22,0.5);
       
       %%%%%%GRIP AND PREPARE FOR ROTATE
       disp('GRIP AND PREPARE FOR ROTATE');
       sGrip.MWriteTime(10,60,0.5);
       sElbow.MWriteTime(delta22,0,0.5);
       sShoulder.MWriteTime(delta11,0,0.5);
       sElbow.MWriteTime(0,30,0.5);
       pause(0.5);
       
       
       %%%%%%MOVE ABOVE DESTINATION AND PREPARE FOR DROP
       disp('MOVE ABOVE DESTINATION AND PREPARE FOR DROP');
       X=30; %%%%%%%%
       Y=30;%%%%%%%
       theta5=45;%%%%%%%%%
       if shape==1
            theta4=237;
       end
       if shape==2
           X=0;%%%%%%%%%
           theta5=90;%%%%%%%%%%%%%
           theta4=280;
       end
       if shape==3
          theta4=320;
       end
       
       sTwist.MWriteTime(theta3,theta4,1);
       pause(1);
       
       
       %%%%%%RELEASE AND RETURN TO INITIAL POSITION
       disp('RELEASE AND RETURN TO INITIAL POSITION');
       
       
       
       
           %%%%%%%%
       
       if shape~=2
           [delta111,delta222]=angleCalcLast(X,Y,20)%%%%%%%%%
           sElbow.MWriteTime(30,delta222,0.5);%%%%%%%
           %pause(0.1); 
            sShoulder.MWriteTime(0,delta111,0.5);%%%%%%%%%%%%%%%%
            %pause(0.1);%%%%%%%
       else 
           delta222=30;
       end
       
   
       
       sGripTwist.MWriteTime(theta3,theta5,0.5);%%%%%%%%
       %pause(1);%%%%%%%%%%%
       
       
       
       sGrip.MWrite(10);
       pause(0.5);
       
       sTwist.MWriteTime(theta4,180,0.5);
       pause(0.5);
       
       sElbow.MWriteTime(delta222,45,0.5);%%%%%%%%%%%
       
       if shape~=2
            sShoulder.MWriteTime(delta111,0,0.5); %%%%%%%%%%%%
       end
       
       %sGripTwist.MWriteTime(theta5,90,1); %%%%%%%%%%%
       
       
       
 end
 
 





