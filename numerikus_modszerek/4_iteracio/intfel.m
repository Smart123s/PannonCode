% lehetseges modositasok ZH-n:

% kerjuk be console-ról

% kerjuk be vektorkent a,b-t
% function intfel(f,v,t)
% a=v(1);
% b=v(2);
% futtatas: intfel(@gf2,[0,1.5], 10^-4)

% leallasi feltétel legyen:
% felezopontban vett fuggvenyertek kozel van a nullahoz
%c=(a+b)/2
%abs(f(c))

function intfel(f,a,b,t)
    l=1;
    while abs(b-a)>=t && l < 100
        c=(a+b)/2;
        if f(a)*f(c) < 0 
            b=c;
        elseif f(b)*f(c) < 0
            a=c;
        else
            fprintf('%d. lépésben a pontos megoldás: %6f\n',l,c)
            return
        end
        fprintf('%d. lépésben a közelítõ megoldás: %6f\n',l,c)
        l=l+1;
    end
end