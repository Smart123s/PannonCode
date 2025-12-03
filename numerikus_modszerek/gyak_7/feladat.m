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
% Lepesszam tullepes, nincs megoldas


fixpont(@fixf2,10^-4)
% Kezdopont: 1.5 mindegyik futtatasban
% A 16 lépésben a közelítõ megoldás: 1.717611

szelo(@h,1,2,10^-4)
% 4. lépésben a közelítõ gyök: 1.717662
