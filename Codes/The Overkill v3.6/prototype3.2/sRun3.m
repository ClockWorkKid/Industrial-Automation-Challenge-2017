function sRun3(s1,s2,s3,firstA,finalA,second)

 delay = second/abs(firstA-finalA);
 
 if firstA>finalA
     flag = -1;
 end;
 if firstA<finalA
     flag = 1;
 for firstA=firstA:flag:finalA
      writePosition(s1 , firstA*(165/180)/180);
      writePosition(s2 , firstA*(165/180)/180);
      writePosition(s3 , firstA*(165/180)/180);
      pause(delay);
 end;
 end
 