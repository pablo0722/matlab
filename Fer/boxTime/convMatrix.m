function [ X ] = convMatrix( x,p )
%CONVMATRIX Summary of this function goes here
%   Detailed explanation goes here

    N = length(x) + 2*(p-1);
    x = x';
    xpad = [zeros(p-1,1);x;zeros(p-1,1)];
    
    for i = 1:p
        X(:,i) = xpad(p-i+1:N-i+1);
    end;


end

