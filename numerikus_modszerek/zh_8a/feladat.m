fplot(@f)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-5;5];
ax.YLim = [-5;5];
ax.NextPlot = "add";

fplot(@g)


fixpont(@fixf1,10^-4)
% Kezdopont: 1.5 mindegyik futtatasban
% A 3 lépésben a közelítõ megoldás: 1.764908


fixpont(@fixf2,10^-4)
% Kezdopont: 1.5 mindegyik futtatasban
% A kiirt szam negítiv, tehat megoldas komplex szam

hur(@h,1,2,10^-4)
% 6 lépésben a közelítõ gyök: 1.764911
