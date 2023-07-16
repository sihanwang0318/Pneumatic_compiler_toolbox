clear s
tic
delete(instrfind({'Port'},{'COM11'}));
if(exist('s','var'))
    fclose(s);
end
baud = 9600;
s = serialport('COM11',baud);
configureTerminator(s,"LF");
configureCallback(s,"terminator",@ReadfromArduino);
flush(s);
pause(2);

figure;

function ReadfromArduino(s,~)
    serialIn = readline(s);
    C = strsplit(serialIn,' ');
    data = str2double(C);
    s.UserData(end+1,1:7) = [data toc];
    bar(data);
    ylim([-10 50])
end