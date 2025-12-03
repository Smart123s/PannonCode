function szelo(f,a,b,t)

    % ZH MODOSITAS KEZDETE
    if abs(f(a)) <= t
        disp('A kezdpont már pontos megoldás.');
        return
    end
    if abs(f(b)) <= t
        disp('B kezdpont már pontos megoldás.');
        return
    end
    % ZH MODOSITAS VEGE

    % Ez az l=1 sor hianyzott a Moodle-be feltoltott anyagbol
    l=1
    p=b-f(b)*(b-a)/(f(b)-f(a));
    while abs(f(p))>=t && l < 100 
        if f(a)-f(b) == 0
            fprintf('Nem található megoldás, a szelõ párhuzamos az x tengellyel!\n')
            return
        end
        p=b-f(b)*(b-a)/(f(b)-f(a));
        fprintf('%d. lépésben a közelítõ gyök: %6f\n',l,p)
        a=b;
        b=p;
        l=l+1;
    end
end
