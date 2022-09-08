function [cordPixFinal,shapeFinal]=confirmBox(cam)
    
    while true
        difference = 2; %pixel
        timeGap = 4;%seconds
        [cordPix,shape]=img_process2(cam);
        pause(timeGap);
        [cordPix2,shape2]=img_process2(cam);
        if(abs(cordPix(1)-cordPix2(1))<=difference)...
                &&(abs(cordPix(2)-cordPix(2))<=difference)
            break
       
            
        end
    end
    
    cordPixFinal=cordPix;
    shapeFinal=shape;
    
    
    
end