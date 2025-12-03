% ZH MODOSITASOK
function szelo(f,v,t)
    a=v(1);
    b=v(2);

    % ZH MODOSITAS VEGE

    % l=1 sor hianyzott Moodle-bol, tanoran is beszeltuk
    l=1;
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
