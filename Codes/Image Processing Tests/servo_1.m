a = arduino;
% while true
%     writeDigitalPin(a,'D13',1);
%     pause(1);
%     writeDigitalPin(a,'D13',0);
%     pause(1);
% end;
s = servo(a, 'D4');
angle=0;
angle=(angle*160)/(180*180.0);

writePosition(s, angle);

% angle0=0.0;

% while true
%     volt=readVoltage(a, 'A0');
%     angle=((volt/5.0)*(165/180.0));
%     if (abs(angle-angle0)>=((5*2.5)/180.0))
%         writePosition(s, angle);
%         angle0=angle
%     end;
%     pause(.01);
% end;


% while b
% for angle = 0:(1/180):(165/180)
%        writePosition(s, angle);
%        current_pos = readPosition(s);
%        current_pos = current_pos*180;
%        fprintf('Current motor position is %d degrees\n', current_pos);
%        pause(.01);
% end;
% for angle = (165/180):(-1/180):(1/180)
%        writePosition(s, angle);
%        current_pos = readPosition(s);
%        current_pos = current_pos*180;
%        fprintf('Current motor position is %d degrees\n', current_pos);
%        pause(.01);
% end;
% end;

%clear a s