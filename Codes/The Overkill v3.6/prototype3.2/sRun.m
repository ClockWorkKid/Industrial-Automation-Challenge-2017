function sRun(s,mType,firstA,finalA,init0,second) 

if mType==0 %plastic gear small motor
    AchieveA=165;
    ExpectedA=180;
end;
if mType==1 %metal gear small motor
    AchieveA=250;
    ExpectedA=250;
end;
if mType==2 %large motor
    AchieveA=165;
    ExpectedA=180;
end;

delay = second/abs(firstA-finalA);
if firstA>finalA
     flag = -1;
 end;
 if firstA<finalA
     flag = 1;
 end;


for firstA=firstA:flag:finalA
    writePosition(s , (firstA+init0)*(AchieveA/ExpectedA)/ExpectedA);
    pause(delay);
end;



end



 %servoRun(sShoulderTwist,sShoulderTwistAngle,theta3,78,250,250,0.03)
 
 %   for sShoulderTwistAngle=sShoulderTwistAngle:-1:theta3
%       writePosition(sShoulderTwist, (sShoulderTwistAngle-78)/250);
%       pause(0.03);
%   end;