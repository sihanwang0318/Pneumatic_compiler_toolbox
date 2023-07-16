function output = performance(result, signalset)

gateset = getGateset(result);
[lineset, terminal] = getLineset(signalset, gateset);
[layer, layerNo] = getLayer(lineset);
minD = shortestDistance(lineset, terminal);
C_length = totalChannelLength(lineset);
output = [layerNo  minD  C_length ];
end

