function y=varian_ce(n);
    N = 0 ;
    Nsqr = 0 ;
    for i = 1:n
        x = 1000*rand() ;
        N = N + x ;
        Nsqr = Nsqr + x*x ;
    end
    avg = N / n ;
    sum = Nsqr - 2 * N * avg + n* avg * avg ; 
    y = sum / n;       
end