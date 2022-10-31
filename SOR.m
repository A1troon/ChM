function [W] = SOR(n, A, b, w0, w , niterations)

W = w0;

for k = 1 : niterations
     W_old = W;
    for i = 1 : n
         W(i) = (b(i) - A(i , 1 : i - 1) * W(1 : i - 1) - A(i , i + 1 : n) * W_old(i + 1 : n)) / A(i, i);
    end
    W = w * W + (1 - w) * W_old;
    
end