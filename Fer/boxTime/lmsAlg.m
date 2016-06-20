function [ W,Y,E ] = lmsAlg( x,d,mu,nord,a0 )
%LMSALG Summary of this function goes here
%   Detailed explanation goes here
    X = convMatrix(x,nord);
    [M,N] = size(X);
    
    if nargin < 5
        a0 = zeros(1,N);
    end;
    
    a0 = a0(:).';
    Y(1) = a0*X(1,:).';
    E(1) = d(1) - Y(1);
    W(1,:) = a0 + mu*E(1)*conj(X(1,:));
    
    if M>1
        for k = 2 : M-nord+1
            Y(k) = W(k-1,:)*X(k,:).';
            E(k) = d(k) - Y(k);
            W(k,:) = W(k-1,:) + mu*E(k)*conj(X(k,:));
        end;
    end;
    
end

