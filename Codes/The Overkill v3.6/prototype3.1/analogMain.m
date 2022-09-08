clear all;
clc;


 a = arduino('com3','uno');
 aa =arduino('com4','uno');
 
  sShoulderTwist = servo(aa, 'D7');
  sShoulder1 = servo(aa, 'D4');
  sShoulder2 = servo(aa, 'D5');
 sShoulder3 = servo(aa, 'D3');
 sElbow = servo(aa, 'D6');
  sGrip = servo(aa, 'D8');
  sGripTwist = servo(aa, 'D9');
 while true
 x=[readVoltage(a,'A1'),readVoltage(a,'A2'),readVoltage(a,'A3'),...
    readVoltage(a,'A4'),readVoltage(a,'A5')]
 
 writePosition(sShoulderTwist,x(1)/10);
 writePosition(sShoulder1,x(2)/10);
 writePosition(sShoulder2,x(2)/10);
 writePosition(sShoulder3,x(2)/10);
 writePosition(sElbow,x(3)/10);
 writePosition(sGrip,x(4)/10);
 writePosition(sGripTwist,x(5)/10);
 
 
 
 
 
 end;

 
 
 
 
 
  

 





