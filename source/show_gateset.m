function show_gateset(space, gateset)     
    img_not  = imread('not.png');
    img_and = imread('and.png');
    img_or = imread('or.png');
    imagesc(double(space));
    Cmap = [0.8 0.8 0.8
        1 1 1];
    colormap(Cmap);

    axis equal
    axis on
    box off
    hold on
    xlim([.5 width(space)+0.5])
    ylim([.5 height(space)+0.5])
    for i = 1:length(gateset)
        gate_tmp = gateset(i);
        hold on
        if gate_tmp.type == 1
            image('CData',imrotate(img_not,(gate_tmp.ang-1)*90),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+0.5], 'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+0.5])
        elseif gate_tmp.type == 2 && gate_tmp.ang == 1
            image('CData',imrotate(img_and,90),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+1.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+0.5])
        elseif gate_tmp.type == 2 && gate_tmp.ang == 2
            image('CData',imrotate(img_and,180),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-1.5 gate_tmp.pos(2)+0.5]) 
        elseif gate_tmp.type == 2 && gate_tmp.ang == 3
            image('CData',imrotate(img_and,270),'XData',[gate_tmp.pos(1)-1.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+0.5])
        elseif gate_tmp.type == 2 && gate_tmp.ang == 4
            image('CData',imrotate(img_and,0),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+1.5])
        elseif gate_tmp.type == 3 && gate_tmp.ang == 1
            image('CData',imrotate(img_or,90),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+1.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+0.5])
        elseif gate_tmp.type == 3 && gate_tmp.ang == 2
            image('CData',imrotate(img_or,180),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-1.5 gate_tmp.pos(2)+0.5]) 
        elseif gate_tmp.type == 3 && gate_tmp.ang == 3
            image('CData',imrotate(img_or,270),'XData',[gate_tmp.pos(1)-1.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+0.5])
        elseif gate_tmp.type == 3 && gate_tmp.ang == 4
            image('CData',imrotate(img_or,0),'XData',[gate_tmp.pos(1)-0.5 gate_tmp.pos(1)+0.5],'YData',[gate_tmp.pos(2)-0.5 gate_tmp.pos(2)+1.5])
        end
        plot(gate_tmp.in1_pos(1),gate_tmp.in1_pos(2),'r.','MarkerSize',20)
        if gate_tmp.in2_pos
            plot(gate_tmp.in2_pos(1),gate_tmp.in2_pos(2),'r.','MarkerSize',20)
        end
        plot(gate_tmp.out_pos(1),gate_tmp.out_pos(2),'g.','MarkerSize',20)
    end
end
