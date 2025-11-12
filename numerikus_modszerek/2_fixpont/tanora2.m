fplot(@fgv2)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-5;5];
ax.YLim = [-5;5];

%% fixpont(@fgv2,0.0001)
fixpont(@fgv2,10^-4)
