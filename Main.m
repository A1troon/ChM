clear all;
close all;
clc;
alpha = 2;
beta = 1;
gamma = 1;
    u = @(x) (x .^ alpha) .* (1 - x) .^ beta;
    p = @(x) 1 + x .^ gamma;
    g = @(x) x + 1;
    pp = @(x) (gamma.*x .^(gamma-1));
    up = @(x) (alpha .* x.^(alpha - 1).*(1-x).^beta - beta .* x.^alpha .* (1-x).^(beta-1));
    upp = @(x) (alpha .* (((alpha - 1).*x.^(alpha-2).*(1-x).^beta) ...
        - beta.*x.^(alpha-1).*(1-x).^(beta-1)) - beta .* (alpha.*x.^(alpha-1).*(1-x).^(beta-1) ...
        - (beta-1).*x.^alpha.*(1-x).^(beta-2)));
    f = @(x) (g(x).*u(x) - pp(x).*up(x) - p(x).*upp(x));
%
%
fprintf('%-15s%-15s%-15s%-15s%-15s\n','n','h','||u - yh||','||u - yh||/h^2','Время работы')
H = [];
errProgonka = [];
for n = 70:62:1000
    h = 1/n;
    [ah, bh, ch, fh, grid] = BuildSystem(n,u,p,g,pp,up,upp,f);
    %A = diag(bh, 0) + diag(ah, -1) + diag(ch, 1);
    %y1 = A\fh;
    %err1 = norm(y1-u(grid),"inf");
    ah = [0, ah']';
    ch = [ch', 0]';
    tic
    y2 = progonka(ah,bh, ch, fh);
    time = toc;
    err2 = norm(y2-u(grid),"inf");
    fprintf('%-15d%-15d%-15d%-15d%-15d\n',n,h,err2,err2*n*n,time);
    H = [H h];
    errProgonka = [errProgonka err2*n*n];
end
plot(log(H),log(errProgonka));
xlabel('ln(h)');
ylabel('ln(||u - yh||/h^2)');
%-------------------------
n = 10;
h = 1/n;
eps = h *h ;
[ah, bh, ch, fh, grid] = BuildSystem(n,u,p,g,pp,up,upp,f);
A = diag(bh, 0) + diag(ah, -1) + diag(ch, 1);
ah = [0, ah']';
ch = [ch', 0]';
kIter = [];
errRelax = [];
fprintf('%-15s%-15s%-15s\n','t(h(n)=500)','k(кол-во итер)','||u - yh||');
W = linspace(0,1,15);
for w = W
    [y3,niter,r] = Relax(ah,bh,ch,fh,w,h*h,[],10000);
    err3 = norm(y3-u(grid),"inf");
    fprintf('%-15d%-15d%-15d\n',w,niter,err3);
    kIter = [kIter niter];
    errRelax = [errRelax err3];
end
%-------------------
[y5] = Gauss_Seidel_Funct(A, fh, 10e-6);
err5 = norm(y5-u(grid),"inf");
[y4,niter,r] = Seidel(ah,bh,ch,fh,h*h*h,[],10000);
err4 = norm(y4-u(grid),"inf");
y1 = A\fh;
err1 = norm(y1-u(grid),"inf");
[y7,niter,r] = Relax(ah,bh,ch,fh,0.07,h*h*h,[],10000);
err7 = norm(y7-u(grid),"inf");
%--------------
figure
tiledlayout(2,1)
nexttile
plot(W,kIter);
title('Зависимость 𝜏 и количества итераций')
xlabel('𝜏');
ylabel('iter');
nexttile
plot(W,errRelax);
title('Зависимость 𝜏 и погрешности')
xlabel('𝜏');
ylabel('||u - yh||');
%---------------------------------
fprintf('%-15s%-15s%-15s%-15s%-15s%-15s\n','n','h','k(кол-во ит)','||u - yh||','||u - yh||/h^2','Время работы')
H = [];
errRelax = [];
for n = 70:62:1000
    h = 1/n;
    [ah, bh, ch, fh, grid] = BuildSystem(n,u,p,g,pp,up,upp,f);
    ah = [0, ah']';
    ch = [ch', 0]';
    tic
    [y3,niter,r] = Seidel(ah,bh,ch,fh,h*h,[],1000000);
    time = toc;
    err3 = norm(y3-u(grid),"inf");
    fprintf('%-15d%-15d%-15d%-15d%-15d%-15d\n',n,h*h,niter,err3,err3*n*n,time);
    H = [H h];
    errRelax = [errRelax err2*n*n];
end
