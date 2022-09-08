a = arduino
for i=1:1:1000
writeDigitalPin(a,'D13',1);
pause(1);
writeDigitalPin(a,'D13',0);
pause(1);
end;