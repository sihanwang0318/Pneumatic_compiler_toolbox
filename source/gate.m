classdef gate
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        type
        order
        pos
        ang
        in_pos
        out_pos
    end
   methods
       function obj = gate(type, order, pos, ang, in_pos, out_pos)
           obj.type = type;
           obj.order = order;
           obj.pos = pos;
           obj.ang = ang;
           obj.in_pos = in_pos;
           obj.out_pos = out_pos;
       end
   end
end

