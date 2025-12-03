function fixpont_hibahatar(f,a,t)
    %   f - Fuggveny
    %   a - Kezdo ertek
    %   t - Hibahatar

    % konzolrol olvasas:
    % a=input('Kérem a kezdõpontot: ');

    l=1;
    while abs(f(a)-a)>t & l<100
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %6f\n',l,a)
        l=l+1;
    end
end


% --------

function fixpont_lepesszam(f,a,n)
    % fixpont fuggveny, de hibahatar helyett futasok darabszaamat megadva
    %   f - Fuggveny
    %   a - Kezdo ertek
    %   n - Lepesek szama
    for i=1:n
        a=f(a);
        fprintf('A %d lépésben a közelítõ megoldás: %1.15f\n',i,a)
    end
end


% --------

% fuggveny (f.m) pelda
function [y] = f(x)
    y = sqrt(exp(atan(x))-sqrt(x));
end


% --------

% futtatas (valami.m)

fplot(@f)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-1;5];
ax.YLim = [-5;5];
ax.NextPlot = "add";

fplot(@g)

fixpont_hibahatar(@fixf1, 1, 10^-4)
% Ha negatív a szám, akkor:
% Megoldás: x=1 kezdponttal nincs megoldás, az eljárás kilépett a komplex
% számsíkra

fixpont_hibahatar(@fixf2, 1, 10^-4)
% Nem találtunk megoldást x=1 kezdponttal, a lépésszám korlát miatt leállt
% a program

fixpont_hibahatar(@fixf3, 1, 10^-4)
% X=1 kezdponttal 5. lépésben a megoldás: 1.1247


% for ciklusos fixpont fuggveny kiprobalasa
fixpont_lepesszam(@fixf3, 1, 10)
