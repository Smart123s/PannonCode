% A csoport (9 ora)

fplot(@f)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-5;5];
ax.YLim = [-5;5];
ax.NextPlot = "add";

fplot(@g)

fixpont(@fixf1,10^-4)
% Kezdopont: 0.5
% A 2 lépésben a közelítõ megoldás: 0.511222


fixpont(@fixf2,10^-4)
% Kezdopont: -1.5
% A 1 lépésben a közelítõ megoldás: -2.210157
% A kiirt szam negítiv, tehat megoldas komplex szam

fixpont(@fixf1,10^-4)
% Kezdopont: -1.5
% A 7 lépésben a közelítõ megoldás: 0.511218

fixpont(@fixf1,10^-4)
% Kezdopont: 0.511222
% A kezdopont pontos megoldas

szelo(@h,[0,1], 10^-4)
% 4. lépésben a közelítõ gyök: 0.511225

szelo(@h,[-2,-1], 10^-4)
% 8. lépésben a közelítõ gyök: -1.516774
