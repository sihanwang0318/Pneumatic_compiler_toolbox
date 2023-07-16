function [concave_edges] = getConcaveEdges(space)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
concave_edges = [];
x = max(space,[],1);
idx1 = 1;
idx2 = length(x);
while ~x(idx1)
    idx1 = idx1 + 1;
end
while ~x(idx2)
   idx2 = idx2 - 1; 
end
left_bond = idx1;
right_bond = idx2;


y = max(space,[],2);
idx1 = 1;
idx2 = length(y);
while ~y(idx1)
    idx1 = idx1 + 1;
end
while ~y(idx2)
   idx2 = idx2 - 1; 
end
up_bond = idx1;
low_bond = idx2;
dx = [1 0 -1 0];
dy = [0 -1 0 1];
dx1 = [0.5 -0.5 -0.5 0.5];
dy1 = [-0.5 -0.5 0.5 0.5];
dx2 = [0.5 0.5 -0.5 -0.5];
dy2 = [0.5 -0.5 -0.5 0.5];
for i = up_bond:low_bond
    for j = left_bond:right_bond
        if ~space(i,j)
            for n = 1:4
                if j+dx(n) > 0 && j + dx(n) <= width(space) &&  i+dy(n) > 0 && i + dy(n) <= height(space) 
                    if space(i+dy(n),j+dx(n)) 
                        concave_edges = [concave_edges; j + dx1(n) i + dy1(n) j + dx2(n) i + dy2(n)];
                    end
                end
            end
        end
    end
end
end

