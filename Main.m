alpha = 2;
beta = 1;
gamma = 1;
n = 40;

[ah, bh, ch, fh] = BuildSystem(alpha,beta,gamma,n);

x = progonka(ah,bh, ch, fh)

error=norm(fh - , "inf");