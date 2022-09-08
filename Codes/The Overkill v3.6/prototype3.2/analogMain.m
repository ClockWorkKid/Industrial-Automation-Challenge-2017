clear all;
clc;


 a = arduino('com9','uno');
 aa =arduino('com8','uno');
 
  sShoulderTwist = servo(aa, 'D9');
  sShoulder1 = servo(aa, 'D4');
  sShoulder2 = servo(aa, 'D5');
 sShoulder3 = servo(aa, 'D6');
 sElbow = servo(aa, 'D8');
  sGrip = servo(aa, 'D12');
  sGripTwist = servo(aa, 'D13');
 while true
 
 %readVoltage(a,'A0')
 x=[readVoltage(a,'A1'),readVoltage(a,'A2'),readVoltage(a,'A3'),...
    readVoltage(a,'A4')]
 
 writePosition(sShoulderTwist,x(1)/10);
 writePosition(sShoulder1,x(2)/10);
 writePosition(sShoulder2,x(2)/10);
 writePosition(sShoulder3,x(2)/10);
 writePosition(sElbow,x(3)/10);
 writePosition(sGrip,x(4)/10);
 %writePosition(sGripTwist,x(5)/10);
 
 
 
 
 
 end;

 
 
 
 
 
  

 





