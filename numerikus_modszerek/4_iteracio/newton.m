function newton(f,df,t)
    a=input('Kérem a kezdõpontot: ')
    if f(a)==0 | abs(f(a))<t
        fprintf('A kezdõpont megoldás!\n')
        return
    end
    l=1;
    while abs(f(a))>=t && l < 100
    if df(a) == 0
        fprintf('Nem található megoldás, az érintõ párhuzamos az x tengellyel!\n')
        return
    end
    a=a-f(a)/df(a);
    fprintf('%d. lépés után a közelítõ megoldás: %6f\n',l,a)
    l=l+1;
    end
end
