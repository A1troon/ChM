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
