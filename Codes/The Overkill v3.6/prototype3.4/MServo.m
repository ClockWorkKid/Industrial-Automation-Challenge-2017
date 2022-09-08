classdef MServo
   properties
      s
      tuning 
      TAngle
      AAngle
   end
   methods
      function servoObj = MServo(arduino,pin,tuning,TAngle,AAngle)
          servoObj.s=servo(arduino,pin);
          servoObj.TAngle=TAngle;
          servoObj.AAngle=AAngle;
          servoObj.tuning=tuning;
      end
      function MWrite(obj,angle)
         writePosition([obj.s],(((angle+[obj.tuning])*[obj.AAngle])/...
             ([obj.TAngle]^2))); 
      end
      function MWriteTime(obj,initAngle,finalAngle, time)
         if initAngle>=finalAngle
             flag=-1;
         else
             flag=1;
         end
         duration=time/(abs(initAngle-finalAngle));
         if initAngle==finalAngle
             writePosition([obj.s],(((initAngle+[obj.tuning])...
                *[obj.AAngle])/([obj.TAngle]^2))); 
         else
         for initAngle=initAngle:flag:finalAngle
            writePosition([obj.s],(((initAngle+[obj.tuning])...
                *[obj.AAngle])/([obj.TAngle]^2))); 
            pause(duration);
         end
         end
      end
   end
end