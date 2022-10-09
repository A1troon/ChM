% alpha = 2;
% beta = 1;
% gamma = 1;
% 
% u = @(x) (x .^ alpha) .* (1 - x) .^ beta;
% p = @(x) 1 + x .^ gamma;
% g = @(x) x + 1;
% pp = @(x) (gamma.*x .^(gamma-1));
% up = @(x) (alpha .* x.^(alpha - 1).*(1-x).^beta - beta .* x.^alpha .* (1-x).^(beta-1));
% upp = @(x) (alpha .* (((alpha - 1).*x.^(alpha-2).*(1-x).^beta) ...
%     - beta.*x.^(alpha-1).*(1-x).^(beta-1)) - beta .* (alpha.*x.^(alpha-1).*(1-x).^(beta-1) ...
%     - (beta-1).*x.^alpha.*(1-x).^(beta-2)));
% f = @(x) (g(x).*u(x) - pp(x).*up(x) - p(x).*upp(x));
% 
% n = [10, 40];
% 
% for k = n
%     h = 1/k;
%     eps = h * h * h;
%     i = (1 : k-1)';
%     x = h * i;
%     a = @(i) (p(h * (i-1)) + p(h*i))/2;
% 
%     A = diag(a(i) + a(i+1) + h^2 * g(i*h), 0) - diag(a(i(2:k-1)), -1) - diag(a(i(2:k-1)), 1);
%     F = h^2 * f(i*h);
%     y=A\F;
% 
%     er=norm(A\F - u(x), "inf");
% end