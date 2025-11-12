fplot(@f)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-1;5];
ax.YLim = [-5;5];
ax.NextPlot = "add";

fplot(@g)

fixpont(@fixf1, 1, 10^-4)
% Ha negatív a szám, akkor:
% Megoldás: x=1 kezdőponttal nincs megoldás, az eljárás kilépett a komplex
% számsíkra

fixpont(@fixf2, 1, 10^-4)
% Nem találtunk megoldást x=1 kezdőponttal, a lépésszám korlát miatt leállt
% a program

fixpont(@fixf3, 1, 10^-4)
% X=1 kezdőponttal 5. lépésben a megoldás: 1.1247


% for ciklusos fixpont fuggveny kiprobalasa
fixpont2(@fixf3, 1, 10)
