function [ah, bh, ch, fh] = BuildSystem(alpha,beta,gamma,n)
u = @(x) (x .^ alpha) .* (1 - x) .^ beta;
p = @(x) 1 + x .^ gamma;
g = @(x) x + 1;
pp = @(x) (gamma.*x .^(gamma-1));
up = @(x) (alpha .* x.^(alpha - 1).*(1-x).^beta - beta .* x.^alpha .* (1-x).^(beta-1));
upp = @(x) (alpha .* (((alpha - 1).*x.^(alpha-2).*(1-x).^beta) ...
    - beta.*x.^(alpha-1).*(1-x).^(beta-1)) - beta .* (alpha.*x.^(alpha-1).*(1-x).^(beta-1) ...
    - (beta-1).*x.^alpha.*(1-x).^(beta-2)));
f = @(x) (g(x).*u(x) - pp(x).*up(x) - p(x).*upp(x));
h = 1/n;
eps = h * h * h;
i = (1 : n-1)';
x = h * i;
a = @(i) (p(h * (i-1)) + p(h*i))/2;
ah = [0, a(i(2:n-1)).'];
bh = a(i) + a(i+1) + h^2 * g(i*h);
ch = [a(i(2:n-1)).',0];
fh = h^2 * f(i*h);
%A = ah + bh + ch;
%y = A \ fh;
%error=norm(y - u(x), "inf");
end