function fixpont(f,a,t)
    %   f - Fuggveny
    %   a - Kezdo ertek
    %   t - Hibahatar
    l=1;
    while abs(f(a)-a)>t & l<100
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %6f\n',l,a)
        l=l+1;
    end
end
