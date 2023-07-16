function gateset = getGateset(result,not_num, and_num, or_num)
    gateset = zeros(not_num + and_num + or_num, 11);
    T = zeros(2,2,4);
    T(:,:,1) = [1 0;0 1];
    T(:,:,2) = [0 1;-1 0];
    T(:,:,3) = [-1 0; 0 -1];
    T(:,:,4) = [0 -1;1 0];
    idx = 1;
    for i = 1:height(result)
        for j = 1:width(result)
            tmp = result(i,j,:);
            if tmp(1) == 1              
                gateset(idx,:) = [1 tmp(2) j i tmp(3) ([j;i]+T(:,:,tmp(3))*[-0.4;0]).' nan nan ([j;i]+T(:,:,tmp(3))*[0.4;0]).'];
                idx = idx +1;
            elseif tmp(1) == 2 && tmp(end) ==1
                gateset(idx,:) = [2 tmp(2) j i tmp(3) ([j;i]+T(:,:,tmp(3))*[0.125;0.4]).' ([j;i]+T(:,:,tmp(3))*[0.875;0.4]).' ([j;i]+T(:,:,tmp(3))*[0.125;-0.4]).' ];
                idx = idx +1;
            elseif tmp(1) == 3 && tmp(end) ==1
                gateset(idx,:) = [3 tmp(2) j i tmp(3) ([j;i]+T(:,:,tmp(3))*[0.125;0.4]).' ([j;i]+T(:,:,tmp(3))*[0.875;0.4]).' ([j;i]+T(:,:,tmp(3))*[0.125;-0.4]).' ];
                idx = idx +1;
            end
        end
    end
    
    [x,y]=sort(100*gateset(:,1) + gateset(:,5));
    gateset=gateset(y,:);
end
