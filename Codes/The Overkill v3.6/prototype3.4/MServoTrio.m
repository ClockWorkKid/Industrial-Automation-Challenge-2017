classdef MServoTrio
   properties 
      s1
      s2
      s3
      tunings1
      tunings2
      tunings3
      TAngle
      AAngle
   end
   methods
       function obj=MServoTrio(arduino,pin1,pin2,pin3,tunings1,...
               tunings2,tunings3,TAngle,AAngle)
           obj.s1=servo(arduino,pin1);
           obj.s2=servo(arduino,pin2);
           obj.s3=servo(arduino,pin3);
           obj.tunings1=tunings1;
           obj.tunings2=tunings2;
           obj.tunings3=tunings3;
           obj.TAngle=TAngle;
           obj.AAngle=AAngle;
       end
       function MWrite(obj,angle)
           angle1=((angle+[obj.tunings1])*[obj.AAngle])/([obj.TAngle]^2);
           angle2=((angle+[obj.tunings2])*[obj.AAngle])/([obj.TAngle]^2);
           angle3=((angle+[obj.tunings3])*[obj.AAngle])/([obj.TAngle]^2);
           writePosition([obj.s1],angle1);
           writePosition([obj.s2],angle2);
           writePosition([obj.s3],angle3);
       end
       function MWriteTime(obj,initAngle,finalAngle,time)
           if initAngle>=finalAngle
               flag=-1;
           else
               flag=1;
           end
           duration=time/(abs(initAngle-finalAngle));
           
           if initAngle==finalAngle
               angle=initAngle;
        angle1= (angle+[obj.tunings1])*[obj.AAngle]/([obj.TAngle]^2);
        angle2= (angle+[obj.tunings2])*[obj.AAngle]/([obj.TAngle]^2);
        angle3= (angle+[obj.tunings3])*[obj.AAngle]/([obj.TAngle]^2);
        writePosition([obj.s1],angle1);
        writePosition([obj.s2],angle2);
        writePosition([obj.s3],angle3);       
               
           else
           for angle=initAngle:flag:finalAngle
        angle1= (angle+[obj.tunings1])*[obj.AAngle]/([obj.TAngle]^2);
        angle2= (angle+[obj.tunings2])*[obj.AAngle]/([obj.TAngle]^2);
        angle3= (angle+[obj.tunings3])*[obj.AAngle]/([obj.TAngle]^2);
        writePosition([obj.s1],angle1);
        writePosition([obj.s2],angle2);
        writePosition([obj.s3],angle3);
        pause(duration);
           end
           end
       end
   end
end