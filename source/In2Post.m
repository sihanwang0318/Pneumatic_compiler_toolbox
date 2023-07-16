function postfix_array = In2Post(infix_array)
%UNTITLED3 Summary of this function goes here

    priority = '~&|';
    postfix_array = strings(height(infix_array),1);
    for n = 1:height(infix_array)
        infix = infix_array(n,:);
        infix = char(infix);
        stack = [];
        postfix = '';
        for i = 1:length(infix)
            input = infix(i);
            if double(input) >= 65 && double(input) <= 90 
                postfix = append(postfix, input);
            elseif ismember(input,priority)
                while ~(isempty(stack)) && ismember(stack(end), priority) && find(stack(end) == priority) <= find(input == priority)
                    postfix = append(postfix, stack(end));
                    stack = stack(1:end-1);
                end
                stack = [stack input];
            elseif input == '('
                stack = [stack input];
            elseif input == ')'
                while stack(end) ~= '('
                    postfix = append(postfix, stack(end));
                    stack = stack(1:end-1);
                end
                stack = stack(1:end-1);
            end
        end
    
        while stack
            postfix = append(postfix, stack(end));    
            stack = stack(1:end-1);
        end
        postfix_array(n,1) = postfix;
    end
end

