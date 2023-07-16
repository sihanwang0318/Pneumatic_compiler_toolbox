function [lineset,terminal] = getLineset(short_signalset, gateset, not_num, and_num, or_num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    gate_num = [not_num and_num or_num];  
    raw_lineset = [];
    for i = 1: height(short_signalset)
        signal = short_signalset(i,:);
        if signal(1) == 0
            raw_lineset = [raw_lineset; gateset(sum(gate_num(1:signal(4)-1))+signal(5),4+2*signal(6)) gateset(sum(gate_num(1:signal(4)-1))+signal(5),5+2*signal(6)) nan nan];
            if length(signal) > 6 & ~isnan(signal(7))
                for n = 2:(sum(~isnan(signal))/3 - 1)
                    raw_lineset = [raw_lineset; [gateset(sum(gate_num(1:signal(3*n+1)-1))+signal(3*n+2), 4+2*signal(3*n+3)) gateset(sum(gate_num(1:signal(3*n+1)-1))+signal(3*n+2), 5+2*signal(3*n+3)) gateset(sum(gate_num(1:signal(3*n-2)-1))+signal(3*n-1), 4+2*signal(3*n)) gateset(sum(gate_num(1:signal(3*n-2)-1))+signal(3*n-1), 5+2*signal(3*n))]];
                end
            end
        elseif (signal(1) == 1 || signal(1) == 2 || signal(1) == 3) && signal(4) ~= 4
            raw_lineset = [raw_lineset; gateset(sum(gate_num(1:signal(1)-1))+signal(2), 10) gateset(sum(gate_num(1:signal(1)-1))+signal(2),11) gateset(sum(gate_num(1:signal(4)-1))+signal(5), 4+2*signal(6)) gateset(sum(gate_num(1:signal(4)-1))+signal(5), 5+2*signal(6))];
            if length(signal) > 6 & ~isnan(signal(7))
                for n = 2:(sum(~isnan(signal))/3 - 1)
                    raw_lineset = [raw_lineset; [gateset(sum(gate_num(1:signal(3*n+1)-1))+signal(3*n+2), 4+2*signal(3*n+3)) gateset(sum(gate_num(1:signal(3*n+1)-1))+signal(3*n+2), 5+2*signal(3*n+3)) gateset(sum(gate_num(1:signal(3*n-2)-1))+signal(3*n-1), 4+2*signal(3*n)) gateset(sum(gate_num(1:signal(3*n-2)-1))+signal(3*n-1), 5+2*signal(3*n))]];
                end
            end
        elseif signal(4) == 4
            raw_lineset = [raw_lineset; gateset(sum(gate_num(1:signal(1)-1))+signal(2),10) gateset(sum(gate_num(1:signal(1)-1))+signal(2),11) nan nan];
        end

    end
    lineset = raw_lineset(~(isnan(raw_lineset(:,3))),:);
    terminal = raw_lineset(isnan(raw_lineset(:,3)),:);
    
end


