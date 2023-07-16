function [signal_val, short_signalset] = splitSignalset(signalset)

signal_val = [signalset.val];
max_down_no = 0;
for i = 1:length(signalset)
   max_down_no = max(max_down_no, height(signalset(i).down)); 
end
short_signalset = nan(length(signalset), 3+3*max_down_no);
for i = 1:length(signalset)
   short_signalset(i,1:3) = signalset(i).up;
   for j = 1:height(signalset(i).down)
       short_signalset(i,1+3*j:3+3*j) = signalset(i).down(j,:);
   end
end
end

