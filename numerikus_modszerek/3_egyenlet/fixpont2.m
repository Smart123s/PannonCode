function fixpont2(f,a,n)
    % fixpont fuggveny, de hibahatar helyett futasok darabszaamat megadva
    %   f - Fuggveny
    %   a - Kezdo ertek
    %   n - Lepesek szama
    for i=1:n
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %1.15f\n',i,a)
    end
end
