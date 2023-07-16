classdef signal
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        val
        up
        down
    end
    
    methods
        function obj = signal(val, up, down)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.val = val;
            obj.up = up;
            obj.down = down;
        end
        

    end
end

