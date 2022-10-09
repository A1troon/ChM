function [x1,niter,r] = Seidel(a,b,c,f,tol,x1,maxiter)
    %проверка условий 
    if(size(b,1)==1&&size(b,2)>1)
        b=b';
        fprintf('вектор-строка b был перевернут в вектор- столбец');
    end 
    if(size(x1,1)==1&&size(x1,2)>1)
        b=b';
        fprintf('вектор-строка x0 был перевернут в вектор- столбец');
    end 
    n=length(f);
    if(isempty(tol)) 
        tol=10^-6;
    end 
    if(isempty(x1))
        x1=zeros(n,1);
    end 
    if(isempty(maxiter))
        maxiter=10*n; 
    end	
    a(1)=[];
    c(length(c))=[]; 
    A=diag(b)+diag(c,1)+diag(a,-1); 
    niter=0;
    while	niter<=maxiter 
        niter=niter+1; 
        x0=x1; 
        x1=zeros(n,1);
        for i=1:n
            sum1=0; 
            sum2=0;
            for j=1:i-1
                sum1=sum1+A(i,j)/A(i,i)*x1(j);
            end
            for j=i+1:n
                sum2=sum2+A(i,j)/A(i,i)*x0(j);
            end
            x1(i)=f(i)/A(i,i)-sum1-sum2;
        end
        r(niter)=norm(A*x1-f,inf); 
        if norm(x1-x0,inf)<=tol
            break;
        end
        if niter==maxiter
            fprintf('Достигнуто максимальное количество иттераций %d',maxiter)
        end
    end
end
