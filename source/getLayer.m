function [layer, layer_no] = getLayer(lineset)

out = lineSegmentIntersect(lineset,lineset);

layer = ones(height(lineset),1);
for i = 2 : height(lineset)
    conflict_layer = unique(((out.intAdjacencyMatrix(1:i-1,i) | out.coincAdjacencyMatrix(1:i-1,i))&out.intNormalizedDistance1To2(1:i-1,i) ~= 0 &out.intNormalizedDistance1To2(1:i-1,i) ~= 1) .*layer(1:i-1));
    n = 1;
    while ismember(n,conflict_layer)
       n = n + 1;
    end
    layer(i) = n;
end
layer_no = max(layer);
end

