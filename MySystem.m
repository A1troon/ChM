classdef MySystem
    properties
        u = @(x) (x .^ alpha) .* (1 - x) .^ beta;
        p = @(x) 1 + x .^ gamma;
        g = @(x) x + 1;
        pp = @(x) (gamma.*x .^(gamma-1));
        up = @(x) (alpha .* x.^(alpha - 1).*(1-x).^beta - beta .* x.^alpha .* (1-x).^(beta-1));
        upp = @(x) (alpha .* (((alpha - 1).*x.^(alpha-2).*(1-x).^beta) ...
            - beta.*x.^(alpha-1).*(1-x).^(beta-1)) - beta .* (alpha.*x.^(alpha-1).*(1-x).^(beta-1) ...
            - (beta-1).*x.^alpha.*(1-x).^(beta-2)));
        f = @(x) (g(x).*u(x) - pp(x).*up(x) - p(x).*upp(x));
        n;
        ah;
        bh;
        ch;
        fh;
        h;
        eps;
        x;
    end

    methods
        function obj = MySystem(n)
            obj.n = n;
            h = 1/n;
            obj.eps = h * h * h;
            i = (1 : n-1)';
            obj.x = h * i;
            a = @(i) (p(h * (i-1)) + p(h*i))/2;
            obj.ah = [0, a(i(2:n-1)).'];
            obj.bh = a(i) + a(i+1) + h^2 * g(i*h);
            obj.ch = [a(i(2:n-1)).',0];
            obj.fh = h^2 * f(i*h);
        end

        function [x] = progonka(a,b,c,f)
            %задание длины 
            n=size(f,1);
            % создание матриц 
            alpha=zeros(n,1); 
            beta=zeros(n,1); 
            x=zeros(n,1);
             
            %вычислим первые значения альфа и бета 
            alpha(2)=-c(1)/b(1);
            beta(2)=f(1)/b(1);
            %прямой ход 
            for i =3:n
                alpha(i)=-c(i-1)/(b(i-1)+alpha(i-1)*a(i-1));
                beta(i)=(f(i-1)-a(i-1)*beta(i-1))/(b(i-1)+alpha(i- 1)*a(i-1));
            end
            %вычислим x_n
            x(n)=(f(n)-a(n)*beta(n))/(b(n)+a(n)*alpha(n));
            %обратный ход 
            for i =n-1:-1:1
                x(i)=alpha(i+1)*x(i+1)+beta(i+1);
            end
        end

    end
end