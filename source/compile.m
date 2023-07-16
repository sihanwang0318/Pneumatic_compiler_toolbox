function result = compile(mbox, axes, infix_array, space)


global map not_num and_num or_num results idx 
syms A B C D E F G H I J


%%  Get the required number of each gate
postfix_array = In2Post(infix_array);

%% Get the set of each pneumatic signal (channel), and the number of gates required
[signalset, not_num, and_num, or_num] = getSignalset(postfix_array);
[signal_val, short_signalset] = splitSignalset(signalset);

%% DFS -- searching for all possible gate arrangements on top

map = zeros(height(space),width(space),4);
map(:,:,1) = 4*space;
results = zeros(height(map),width(map),4,4^(not_num+and_num+or_num));
idx = 1;
tic
puzzle_dfs();
dfs_time = toc;
mbox.Value = append('Gate planning Complete in ',num2str(dfs_time, ['%.' num2str(1) 'f']),' seconds!');
drawnow;
%% assessment approach, faster!
tic

concave_edges = getConcaveEdges(space);

p_matrix = nan(idx-1,3);
for i = 1:idx-1
    result = results(:,:,:,i);
    gateset = getGateset(result, not_num, and_num, or_num);
    [lineset, terminal] = getLineset(short_signalset, gateset, not_num, and_num, or_num);
    C_length = totalChannelLength(lineset);
    p_matrix(i,3) = C_length;
end

[B,I] = sort(p_matrix(:,3));

for j = 1:min(height(I),20000)
    result = results(:,:,:,I(j));
    gateset = getGateset(result, not_num, and_num, or_num);
    [lineset, terminal] = getLineset(short_signalset, gateset, not_num, and_num, or_num);
    if ~isempty(concave_edges) && checkBreachedLine(concave_edges, lineset)
        continue
    end
    minD = shortestDistance(lineset, terminal);
    p_matrix(I(j),2) = minD;
    if minD > 0.1
        [layer, layerNo] = getLayer(lineset);
        p_matrix(I(j),1) = layerNo;
    end
end

eval_time = toc;
mbox.Value = [mbox.Value; append('Channel planning and assessment complete in ',num2str(eval_time, ['%.' num2str(1) 'f']),' seconds!')];
drawnow;
%% pick and show the optimal one
score = (p_matrix(:,2)>0.14) .* (100- 10*p_matrix(:,1) - 0.1*p_matrix(:,3));
best_idx = find(score == max(score));
best_idx = best_idx(1);
result = results(:,:,:,best_idx);
show_circuit(axes, result, short_signalset, space, not_num, and_num, or_num);
disp(append('The optimal solution is presented. It has ',string(p_matrix(best_idx,1)),' layer(s), ',string(20*p_matrix(best_idx,3)),'mm total_channel length' ));
mbox.Value = [mbox.Value; append('Compiling complete! The optimal solution has ',string(p_matrix(best_idx,1)),' layer(s), ',num2str(20*p_matrix(best_idx,3), ['%.' num2str(1) 'f']),'mm total_channel length' )];
drawnow;
%% generate 3D printing-ready CAD file
% stl_path = 'C:\Users\Sihan\OneDrive - Nexus365\Sihan\Robosoft2023\LL\DEMUX3.stl';
% mph_path = 'C:\Users\Sihan\OneDrive - Nexus365\Sihan\Robosoft2023\LL\DEMUX3';
% getCAD(result, short_signalset, space,not_num, and_num, or_num, stl_path, mph_path)
% disp(append('CAD file generated and saved to: ', stl_path))
% disp(append('mph file generated and saved to: ', mph_path))



end