function[xn] = Gauss_Seidel_Funct(A, b, tol)

% We need the number of columns & rows
[f,c] = size(A);

% Diagonal is obtained for the cycle
B = A - diag(diag(A));

error = 100;

xa = zeros(f,1);

% This cycle will continue as long as the error is
% greater than the tolerance
niter = 0;
while error > tol
    % Previous value is saved
    xn = xa;
    niter = niter + 1;
    % We obtain the values in the following cycles
    for i = 1 : f
        xn(i) = b (i);
        
        for j = 1 : c
           xn(i) = xn(i) - B(i,j) * xn(j);
        end
        
        xn(i) = xn(i) / A(i,i);
    end
    
    % Formula for the error
    error = norm(xn-xa) / norm(xn) * 100;
    xa = xn;
end
end