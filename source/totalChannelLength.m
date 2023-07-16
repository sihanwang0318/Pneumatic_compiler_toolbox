function [total_length] = totalChannelLength(lineset)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
total_length = sum(sqrt((lineset(:,1)-lineset(:,3)).^2 + (lineset(:,2)-lineset(:,4)).^2));
end

