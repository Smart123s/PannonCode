function fixpont(f,t)
    a=input('Kérem a kezdõpontot: ');

    % ZH MODOSITAS ELEJE
    if abs(f(a)-a) <= t
        fprintf('A kezdopont pontos megoldas\n');
        return;
    end
    % ZH MODOSITAS VEGE

    l=1;
    while abs(f(a)-a)>t & l<100
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %6f\n',l,a)
        l=l+1;
    end
end