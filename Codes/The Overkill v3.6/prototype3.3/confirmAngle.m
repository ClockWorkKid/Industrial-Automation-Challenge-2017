function [delta1,delta2,theta3,confirmation]=confirmAngle(cordPix, wrist)
    lowDelta1 = 0;
    highDelta1 = 90;
    lowDelta2 = 0;
    highDelta2 = 90;
    lowTheta3 = 75; %%%%%TUNING OF sTwist in positive
    highTheta3 = 328;
    confirmation = false;
    [delta1,delta2,theta3]=angleCalc(cordPix,wrist);
    if delta1>lowDelta1 && delta1<highDelta1...
            && delta2>lowDelta2 && delta2<highDelta2...
            && theta3>lowTheta3 && theta3<highTheta3
        
        confirmation = true;
    end
    
end