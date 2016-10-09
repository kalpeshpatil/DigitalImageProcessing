function [ U, S, V ] = mySVD( A )
%% Code here
%  NOTE: Argument matrix A is required to run
%   If v is eigen vector corresponding to eigenc value 'lambda';
%   then -v is also corresponds to the same eigen value, which causes 
%   throuble in creating U and V from A*A' and A'*A
%
%   This problem is solved by selecting proper sign for coloumns of U
%   A = U*S*V'  => A*V = U*S
%   Choose signs for coloumns of U which satisfy above criterion
%   finally norm(A-USV') will be displayed (which will be close to zero)


    [U,S,V] = svd(A);
    [m,n] = size(A);
    [eigVec1, eigVal1] = eig(A*A');
    [eigVec2, eigVal2] = eig(A'*A);
    
    tempVec1 = zeros(m,m);
    tempVec2 = zeros(n,n);
    tempVal = zeros(m,n);
    [m1, n1] = size(eigVal1);
    for i = 1:m
        tempVec1(:,i) = eigVec1(:,m-i+1);
    end
    for i = 1:n
        tempVec2(:,i) = eigVec2(:,n-i+1);
    end
    
    for i = 1:min(m,n);
        tempVal(i,i) = sqrt(eigVal1(m1-i+1,m1-i+1));
    end
    
    B = A*tempVec2;
    C = tempVec1*tempVal;
    
    for i = 1:n
        if(B(:,i)'*C(:,i) >= 0) 
            continue;
        else
            tempVec1(:,i) = -tempVec1(:,i);
        end
    end
    
    U = tempVec1;
    S = tempVal;
    V = tempVec2;
    
    disp(norm(A - U*S*V'));

end

