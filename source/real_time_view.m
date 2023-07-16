tic
pause(.1)

while 1
    time = toc;
    idx = find(abs(input1(:,7)-time) == min(abs(input1(:,7)-time)));
    idx = idx(1);
    plot(input1(1:idx,7), input1(1:idx,2))
    hold on
    plot(input1(1:idx,7), input1(1:idx,3))

    hold off
    pause(.2)
    drawnow
    
end
