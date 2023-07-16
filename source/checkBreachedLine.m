function flag = checkBreachedLine(concave_edges, lineset)
    for i = 1:height(lineset)
        out = lineSegmentIntersect(lineset(i,:),concave_edges);
        if sum(sum(out.intAdjacencyMatrix)) + sum(sum(out.coincAdjacencyMatrix))
            flag = 1;
            return
        end
    end
    flag = 0;            
end

