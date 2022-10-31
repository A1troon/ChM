function [ah, bh, ch, fh, x] = BuildSystem(n,u,p,g,pp,up,upp,f)
    h = 1/n;
    i = (1 : n-1)';
    x = h * i;
    a = @(i) (p(h * (i-1)) + p(h*i))/2;
    ah = -a(i(2:n-1));
    bh = a(i) + a(i+1) + h^2 * g(i*h);
    ch = -a(i(2:n-1));
    fh = h^2 * f(i*h);
end