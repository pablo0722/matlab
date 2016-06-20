function [ y ] = iirFilter( x , b , a )
%IIRFILTER Summary of this function goes here
%   Detailed explanation goes here
    lb = length(b);
    lx = length(x);
    
    if ( isrow(x) == 0 )
        x = x';
    end
    if ( isrow(b) == 0 )
        b = b';
    end
    if ( isrow(a) == 0 )
        a = a';
    end
    
    xx = [ zeros(1,lb-1) , x ];
    yy = [ zeros(1,lb-1) , zeros(1,lx) ];
    bb = fliplr(b);
    aa = fliplr(a);
    
    for k = lb : lx+lb-1
        sum1 = bb(1:end)   * xx( k-(lb-1) : k )';
        sum2 = aa(1:end-1) * yy( k-(lb-1) : k-1 )';
        cnst = 1/aa(end);
        yy(k) = cnst * (sum1 - sum2);
    end
    
    y = yy( lb : lx+lb-1 )';
end