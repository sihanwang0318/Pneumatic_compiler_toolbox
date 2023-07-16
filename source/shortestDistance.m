function minD = shortestDistance(lineset, terminal)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


minD = inf;
for i = 1:height(terminal)
    for j = 1:height(lineset)
        tmp = shortestPLDistance(terminal(i,1), terminal(i,2), lineset(j,1), lineset(j,2), lineset(j,3), lineset(j,4));
        minD = min(minD, tmp);
    end
end
for i = 1:height(lineset)
    for j = 1:height(lineset)
        tmp = shortestPLDistance(lineset(i,1), lineset(i,2), lineset(j,1), lineset(j,2), lineset(j,3), lineset(j,4));
        minD = min(minD, tmp);
        tmp = shortestPLDistance(lineset(i,3), lineset(i,4), lineset(j,1), lineset(j,2), lineset(j,3), lineset(j,4));
        minD = min(minD, tmp);
    end
end

end

