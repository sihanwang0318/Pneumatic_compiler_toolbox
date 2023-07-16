function show_circuit(axes, result, short_signalset, space,not_num, and_num, or_num)    
%% Pre-computing
gateset = getGateset(result,not_num, and_num, or_num);
[lineset, terminal] = getLineset(short_signalset, gateset,not_num, and_num, or_num);
[layer, layerNo] = getLayer(lineset);
hold(axes, 'on');

    
    
    %% Draw each gate
    img_not  = imread('not.png');
    img_and = imread('and.png');
    img_or = imread('or.png');
    for i = 1:height(gateset)
        gate_tmp = gateset(i,:);
        
        if gate_tmp(1) == 1
            image('CData',imrotate(img_not,(gate_tmp(5)-1)*90),'XData',[gate_tmp(3)-1 gate_tmp(3)], 'YData',[gate_tmp(4)-1 gate_tmp(4)],'Parent',axes)
        elseif gate_tmp(1) == 2 && gate_tmp(5) == 1
            image('CData',imrotate(img_and,90),'XData',[gate_tmp(3)-1 gate_tmp(3)+1],'YData',[gate_tmp(4)-1 gate_tmp(4)],'Parent',axes)
        elseif gate_tmp(1) == 2 && gate_tmp(5) == 2
            image('CData',imrotate(img_and,180),'XData',[gate_tmp(3)-1 gate_tmp(3)],'YData',[gate_tmp(4)-2 gate_tmp(4)],'Parent',axes) 
        elseif gate_tmp(1) == 2 && gate_tmp(5) == 3
            image('CData',imrotate(img_and,270),'XData',[gate_tmp(3)-2 gate_tmp(3)],'YData',[gate_tmp(4)-1 gate_tmp(4)],'Parent',axes)
        elseif gate_tmp(1) == 2 && gate_tmp(5) == 4
            image('CData',imrotate(img_and,0),'XData',[gate_tmp(3)-1 gate_tmp(3)],'YData',[gate_tmp(4)-1 gate_tmp(4)+1],'Parent',axes)
        elseif gate_tmp(1) == 3 && gate_tmp(5) == 1
            image('CData',imrotate(img_or,90),'XData',[gate_tmp(3)-1 gate_tmp(3)+1],'YData',[gate_tmp(4)-1 gate_tmp(4)],'Parent',axes)
        elseif gate_tmp(1) == 3 && gate_tmp(5) == 2
            image('CData',imrotate(img_or,180),'XData',[gate_tmp(3)-1 gate_tmp(3)],'YData',[gate_tmp(4)-2 gate_tmp(4)],'Parent',axes) 
        elseif gate_tmp(1) == 3 && gate_tmp(5) == 3
            image('CData',imrotate(img_or,270),'XData',[gate_tmp(3)-2 gate_tmp(3)],'YData',[gate_tmp(4)-1 gate_tmp(4)],'Parent',axes)
        elseif gate_tmp(1) == 3 && gate_tmp(5) == 4
            image('CData',imrotate(img_or,0),'XData',[gate_tmp(3)-1 gate_tmp(3)],'YData',[gate_tmp(4)-1 gate_tmp(4)+1],'Parent',axes)
        end
        scatter(gate_tmp(6)-0.5,gate_tmp(7)-0.5,50, 'MarkerFaceColor','r','MarkerFaceAlpha',0.4,'MarkerEdgeColor','r','MarkerEdgeAlpha',0.2,'Parent',axes)
        if ~isnan(gate_tmp(8))
            scatter(gate_tmp(8)-0.5,gate_tmp(9)-0.5,50, 'MarkerFaceColor','r','MarkerFaceAlpha',0.4,'MarkerEdgeColor','r','MarkerEdgeAlpha',0.2,'Parent',axes)
        end
        scatter(gate_tmp(10)-0.5,gate_tmp(11)-0.5,50, 'MarkerFaceColor','g','MarkerFaceAlpha',0.4,'MarkerEdgeColor','g','MarkerEdgeAlpha',0.2,'Parent',axes)
    end
    %% Draw each channel

    gate_num = [not_num and_num or_num];    
    for i = 1: height(short_signalset)
        signal = short_signalset(i,:);
        if signal(1) == 0
            plot(gateset(sum(gate_num(1:signal(4)-1))+signal(5),4+2*signal(6))-0.5, gateset(sum(gate_num(1:signal(4)-1))+signal(5),5+2*signal(6))-0.5,'r.','MarkerSize',30,'Parent',axes)            
        elseif signal(4) == 4
            plot(gateset(sum(gate_num(1:signal(1)-1))+signal(2),10)-0.5,gateset(sum(gate_num(1:signal(1)-1))+signal(2),11)-0.5,'g.','MarkerSize',30,'Parent',axes)
        end
            
    end
    
    color = parula(max(2,max(layer)));
    for i = 1:height(lineset)
        if lineset(i,3)
            plot(lineset(i,[1 3])-0.5,lineset(i,[2 4])-0.5, 'Color', color(layer(i),:),'LineWidth',3,'Parent',axes)
        end
    end

end
