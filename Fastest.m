function [x0,niter,R] = Fastest(A,b,x0,tol,maxiter)
    %x0-начальное приближение к х
    %tol-критерий точности
    %maxiter-максимальное число итераций
    %niter-число итераций потребовавшихся для достижения критерия точности
    %r-вектор вектор норм невязок на итерациях
    %r(k)=||r^k||
    %проверка условий 
    if(size(b,1)==1&&size(b,2)>1)
        b=b';
        fprintf("вектор-строка b был перевернут в вектор- столбец");
    end 
    if(size(x0,1)==1&&size(x0,2)>1)
        x0=x0';
        fprintf("вектор-строка x0 был перевернут в вектор- столбец");
    end 
    n=size(b,1);
    if(size(A,1)~=n||size(A,2)~=n)
        fprintf("Размеры массива или вектора b не совпадают"); 
        return;
    end 
    if(isempty(tol))
        tol=10^-6;
    end 
    if(isempty(x0))
        x0=zeros(n,1);
    end 
    if(isempty(maxiter))
        maxiter=10*n;
    end
    %основная часть 
    niter=1;
    while (niter<=maxiter) 
        r=A*x0-b;
        t=dot(r,r)/dot(A*r,r); 
        x0=x0-t*r; 
        R(niter)=norm(r,inf);
        if norm(r,inf)<=tol*norm(b,inf)
            break
        end
        if niter==maxiter
            fprintf("Достигнуто максимальное количество иттераций %d",maxiter)
        end 
        niter=niter+1;
    end 
end
