function MWriteSimul(servo1,initAngle1,finalAngle1,...
    servo2,initAngle2,finalAngle2,duration)
    if initAngle1>finalAngle1
        flag1=-1;
    else
        flag1=1;
    end
    if initAngle2>finalAngle2
        flag2=-1;
    else
        flag2=1;
    end
    while ((abs(initAngle1-finalAngle1) >= 0)...
            && (abs(initAngle2-finalAngle2) >= 0))
       if abs(initAngle1-finalAngle1)>=0
           servo1.MWrite(initAngle1);
           initAngle1=initAngle1+flag1;
       end
       if abs(initAngle2-finalAngle2)>=0
           servo2.MWrite(initAngle2);
           initAngle2=initAngle2+flag2;
       end
       pause(duration);
    end
    
    
end