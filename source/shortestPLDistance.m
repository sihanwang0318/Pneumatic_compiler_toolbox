function [output] = shortestPLDistance(x, y, x1, y1, x2, y2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if (x == x1 && y == y1)  || (x == x2 && y == y2) 
    output = inf;
    return 
end
A = x - x1;
B = y - y1;
C = x2 - x1;
D = y2 - y1;

dot = A * C + B * D;
len_sq = C * C + D * D;
param = dot / len_sq;

if param < 0
    xx = x1;
    yy = y1;
elseif param > 1
    xx = x2;
    yy = y2;
else
    xx = x1 + param * C;
    yy = y1 + param * D;
end

dx = x - xx;
dy = y - yy;

output = sqrt(dx*dx + dy*dy);
