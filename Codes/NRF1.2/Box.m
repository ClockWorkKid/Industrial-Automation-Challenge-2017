classdef Box
    properties
        lowHue;
        highHue;
        coX;
        coY;
        HueLimitPercentage=10;
        serial;
    end
    methods
        function obj=Box(Hue,coX,coY)
            obj.coX=coX;
            obj.coY=coY;
            obj.lowHue=Hue-(Hue*HueLimitPercentage/100);
            obj.highHue= Hue+(Hue*HueLimitPercentage/100);
        end
    end
end