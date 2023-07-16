
function puzzle_dfs()
global map not_num and_num or_num results idx
if idx > 1000000
    return
end
if not_num == 0 && and_num == 0 && or_num == 0

    results(:,:,:,idx) = map(:,:,:);
    idx = idx + 1;

    return
end
if ~ismember(4,map(:,:,1))
    return
end

for i = 1:height(map)
    for j = 1:width(map)
        if not(map(i,j,1) == 4)
            continue
        end
        if and_num
           dx = [0 -1 0 1];%right, up, left, down
           dy = [1 0 -1 0];
           
           for n=1:4
              if i + dx(n) >0 && i+dx(n) <= height(map) && j+dy(n) >0 && j+dy(n) <= width(map) && map(i+dx(n),j+dy(n)) == 4                
                  map(i,j,:) = [2 and_num n 1];
                  map(i+dx(n),j+dy(n),:) = [2 and_num rem(n+1,4)+1 2];
                  and_num = and_num - 1;
                  puzzle_dfs()
                  and_num = and_num + 1;
                  map(i+dx(n),j+dy(n),:) = [4 0 0 0];
                  map(i,j,:) = [4 0 0 0];
              end
           end
        elseif or_num
           dx = [0 -1 0 1]; %right, up, left, down
           dy = [1 0 -1 0];
           
           for n=1:4
              if i + dx(n) >0 && i+dx(n) <= height(map) && j+dy(n) >0 && j+dy(n) <= width(map) && map(i+dx(n),j+dy(n)) == 4                
                  map(i,j,:) = [3 or_num n 1];
                  map(i+dx(n),j+dy(n),:) = [3 or_num rem(n+1,4)+1 2];
                  or_num = or_num - 1;
                  puzzle_dfs()
                  or_num = or_num + 1;
                  map(i+dx(n),j+dy(n),:) = [4 0 0 0];
                  map(i,j,:) = [4 0 0 0];
              end
           end          
        else
            for n = 1:4
                map(i,j,:) = [1, not_num, n, 0];
                not_num = not_num - 1;
                puzzle_dfs()
                not_num = not_num + 1;
                map(i,j,:) = [4 0 0 0];
            end
        end
    end
end
end