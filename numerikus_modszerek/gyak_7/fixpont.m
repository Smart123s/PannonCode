function fixpont(f,t)
    a=input('Kérem a kezdõpontot: ');

    % MODOSITAS KEZDETE
    if abs(f(a)-a) <= t
        disp('A megadott kezdpont pontos megoldás.');
        return;
    end
    % MODOSITAS VEGE

    l=1;
    while abs(f(a)-a)>t & l<100
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %6f\n',l,a)
        l=l+1;
    end
end