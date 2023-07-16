% everytime when seeing new variables, check if it's new (if not create it), push in stack
% everytime when seeing gate operator, pop 1 or 2 variables from stack. 
% Let VARIABLE(S).down = gate. 
% Implement gate operation. 
% Check if the output is a new variable, if not create it. 
% NEW_VARIABLE.up = gate. 
% Push the new variable into stack. 
% NEW_VARIABLE.up = gate.
function [signalset, not_num, and_num, or_num] = getSignalset(postfix_array)

syms A B C D E F G H I J
signalset = [];
stack = [];
signal_idx = 1;
input_idx = 1;
not_num = 1;
and_num = 1;
or_num = 1;
out_num = 1;

for j = 1: height(postfix_array)
    postfix = char(postfix_array(j));
    
    for i=1:length(postfix)
        input = postfix(i);
        if double(input) >= 65 && double(input) <= 90 
            tmp = 0;
            for n = length(signalset):-1:1
               if isequal(signalset(n).val, eval(input))
                  tmp = n;
               end
            end
            if tmp == 0
                new_signal = signal(eval(input), [0 input_idx 1],[]);
                input_idx = input_idx + 1;
                signalset = [signalset new_signal];
                stack = [stack signal_idx];
                signal_idx = signal_idx + 1;
            else
                stack = [stack tmp];
            end
        elseif input == '~'
            new_val = ~(signalset(stack(end)).val);
            tmp = 0;
            for n = length(signalset):-1:1
               if isequal(signalset(n).val, new_val)
                  tmp = n;
               end
            end
            if tmp == 0
                signalset(stack(end)).down = [signalset(stack(end)).down; [1 not_num 1]];
                new_signal = signal(~(signalset(stack(end)).val),[1 not_num 1],[]);
                not_num = not_num + 1;
                signalset = [signalset new_signal];
                stack = stack(1:end-1);
                stack = [stack signal_idx];
                signal_idx = signal_idx + 1;
            else
                stack(end) = tmp;
            end
        elseif input == '&'
            new_val = (signalset(stack(end)).val)&(signalset(stack(end-1)).val);
            tmp = 0;
            for n = length(signalset):-1:1
               if isequal(signalset(n).val, new_val)
                  tmp = n;
               end
            end
            if tmp == 0
                signalset(stack(end)).down = [signalset(stack(end)).down; [2 and_num 2]];
                signalset(stack(end-1)).down = [signalset(stack(end-1)).down; [2 and_num 1]];
                new_signal = signal((signalset(stack(end)).val)&(signalset(stack(end-1)).val),[2 and_num 1],[]);
                and_num = and_num + 1;
                signalset = [signalset new_signal];
                stack = stack(1:end-2);
                stack = [stack signal_idx];
                signal_idx = signal_idx + 1;
            else
                stack = stack(1:end-2);
                stack = [stack tmp];
            end

        elseif input == '|'
            new_val = (signalset(stack(end)).val)|(signalset(stack(end-1)).val);
            tmp = 0;
            for n = length(signalset):-1:1
               if isequal(signalset(n).val, new_val)
                  tmp = n;
               end
            end
            if tmp == 0
                signalset(stack(end)).down = [signalset(stack(end)).down; [3 or_num 2]];
                signalset(stack(end-1)).down = [signalset(stack(end-1)).down; [3 or_num 1]];
                new_signal = signal((signalset(stack(end)).val)|(signalset(stack(end-1)).val),[3 or_num 1],[]);
                or_num = or_num + 1;
                signalset = [signalset new_signal];
                stack = stack(1:end-2);
                stack = [stack signal_idx];
                signal_idx = signal_idx + 1;
            else
                stack = stack(1:end-2);
                stack = [stack tmp];
            end
        end
    end
    signalset(stack(end)).down = [4 out_num 1];
    out_num = out_num + 1;
    stack = stack(1:end-1);
end
    not_num = not_num - 1;
    and_num = and_num - 1;
    or_num = or_num - 1;
    out_num = out_num - 1;
    
