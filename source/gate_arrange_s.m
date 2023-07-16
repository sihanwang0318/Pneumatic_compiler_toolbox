clear
global map not_num and_or_num results idx
space = [0 1 1 0;1 1 1 1;1 1 1 1 ;0 1 1 0];
map = space;
map = string(map);
not_num = 2;
and_or_num =4;
results = zeros(height(space),width(space),1000000);
results = string(results);
idx = 1;
tic
dfs()
time = toc;
disp(append('Complete! ',string(idx-1),' solutions found in ',string(toc),' seconds!'));
%% 
result = results(:,:,26);

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


img_not  = imread('not.png');
img_gate = imread('gate.png');





for i =1:height(result)
    for j = 1:width(result)
        tmp = char(result(i,j));
        if tmp(1)=='S'
            if tmp(end) == 'l'
                image('CData',img_not,'XData',[j-0.5 j+0.5],'YData',[i-0.5 i+0.5])
                plot(j-0.4,i,'r.','MarkerSize',20)
                plot(j+0.4,i,'g.','MarkerSize',20)
            elseif tmp(end) == 'r'
                image('CData',img_not,'XData',[j-0.5 j+0.5],'YData',[i-0.5 i+0.5])
                plot(j-0.4,i,'g.','MarkerSize',20)
                plot(j+0.4,i,'r.','MarkerSize',20)
            elseif tmp(end) == 'u'
                image('CData',imrotate(img_not,90),'XData',[j-0.5 j+0.5],'YData',[i-0.5 i+0.5])
                plot(j,i+0.4,'r.','MarkerSize',20)
                plot(j,i-0.4,'g.','MarkerSize',20)
            else
                image('CData',imrotate(img_not,90),'XData',[j-0.5 j+0.5],'YData',[i-0.5 i+0.5])
                plot(j,i+0.4,'r.','MarkerSize',20)
                plot(j,i-0.4,'g.','MarkerSize',20)
            end
        elseif tmp(1) == 'L'
            if tmp(end) == 'a'
                if tmp(end-1) == 'u'
                    image('CData',imrotate(img_gate,180),'XData',[j-0.5 j+0.5],'YData',[i-1.5 i+0.5])
                    plot(j+0.4,i,'r.','MarkerSize',20)
                    plot(j+0.4,i-1,'r.','MarkerSize',20)
                    plot(j-0.4,i,'g.','MarkerSize',20)
                elseif tmp(end-1) == 'd'
                    image('CData',img_gate,'XData',[j-0.5 j+0.5],'YData',[i-0.5 i+1.5])
                    plot(j+0.4,i,'g.','MarkerSize',20)
                    plot(j-0.4,i,'r.','MarkerSize',20)
                    plot(j-0.4,i+1,'r.','MarkerSize',20)
                elseif tmp(end-1) == 'l'
                    image('CData',imrotate(img_gate,270),'XData',[j-1.5 j+0.5],'YData',[i-0.5 i+0.5])
                    plot(j,i-0.4,'r.','MarkerSize',20)
                    plot(j-1,i-0.4,'r.','MarkerSize',20)
                    plot(j,i+0.4,'g.','MarkerSize',20)
                else
                    image('CData',imrotate(img_gate,90),'XData',[j-0.5 j+1.5],'YData',[i-0.5 i+0.5])
                    plot(j,i+0.4,'r.','MarkerSize',20)
                    plot(j+1,i+0.4,'r.','MarkerSize',20)
                    plot(j,i-0.4,'g.','MarkerSize',20)
                end
            end
        end
                
        
    end
end
%% 

axes('pos',[.3 .2 .3 .3])
I = imread('not.png');
J = imrotate(I,90);
imshow(J)


img_not  = imread('not.png');
img_gate = imread('gate.png');
image('CData',img,'XData',[0 1],'YData',[0 1])

%% 


a = BasicClass
%% 
a = BasicClass

%% 






function dfs()
global map not_num and_or_num results idx
if idx > 1000000
    return
end
if not_num == 0 && and_or_num == 0

    results(:,:,idx) = map(:,:);
    idx = idx + 1;

    return
end
if ~ismember('1',map)
    return
end

for i = 1:height(map)
    for j = 1:width(map)
        if not(map(i,j) == '1')
            continue
        end
        if and_or_num
           dx = [0 0 1 -1];
           dy = [1 -1 0 0];
           dir1 = ['r' 'l' 'd' 'u' ];
           dir2 = ['l' 'r' 'u' 'd'];
           for n=[2 3]
              if i + dx(n) >0 && i+dx(n) <= height(map) && j+dy(n) >0 && j+dy(n) <= width(map) && map(i+dx(n),j+dy(n)) =='1'
                
                  map(i,j) = append('L',string(and_or_num),dir1(n),'a');
                  map(i+dx(n),j+dy(n)) = append('L',string(and_or_num),dir2(n),'b');
                  and_or_num = and_or_num - 1;
                  dfs()
                  and_or_num = and_or_num + 1;
                  map(i+dx(n),j+dy(n)) = '1';
                  map(i,j) = '1';
              end
           end
        else
%             map(i,j) = append('S',string(not_num),'d');
%             not_num = not_num - 1;
%             dfs()
%             not_num = not_num + 1;
%             map(i,j) = '1';
            
%             map(i,j) = append('S',string(not_num),'l');
%             not_num = not_num - 1;
%             dfs()
%             not_num = not_num + 1;
%             map(i,j) = '1';
%             
%             map(i,j) = append('S',string(not_num),'u');
%             not_num = not_num - 1;
%             dfs()
%             not_num = not_num + 1;
%             map(i,j) = '1';
            
            map(i,j) = append('S',string(not_num),'r');
            not_num = not_num - 1;
            dfs()
            not_num = not_num + 1;
            map(i,j) = '1';
        end
    end
end
end


%% 
