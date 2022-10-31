clc;
clear all;
up = @(x) (2 .* x.^(2 - 1).*(1-x).^2 - 2 .* x.^2 .* (1-x).^(2-1));
alpha = 2;
beta = 2;
u = @(x) (x .^ alpha) .* (1 - x) .^ beta;
upp = @(x) (alpha .* (((alpha - 1).*x.^(alpha-2).*(1-x).^beta) ...
        - beta.*x.^(alpha-1).*(1-x).^(beta-1)) - beta .* (alpha.*x.^(alpha-1).*(1-x).^(beta-1) ...
        - (beta-1).*x.^alpha.*(1-x).^(beta-2)));

upp(5)