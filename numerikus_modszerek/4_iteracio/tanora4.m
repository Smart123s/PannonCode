fplot(@f2)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-1;10];
ax.YLim = [-1;10];
ax.NextPlot = "add";

fplot(@g2)


% Intervallum felezo modszer
% masodik, harmadik parametert mi olvassuk le az abrarol
intfel(@gf2,0,1.5,10^-4)
% 14 lepes, megoldas: 1.0024
% eleg kimasolni az elso negy szamjegyet, nem kell kerekiteni se

intfel(@gf2,3,4.3,10^-4)
% 14 lepes, megoldas: 4.1740


%Hurmodszer
hur(@gf2,0,1.5,10^-4)
% 100 lepes, nem talalt megoldast, divergens

hur(@gf2,3,4.3,10^-4)
% 15 lepes, megoldas: 4.1740

hur(@gf2,0.5,2,10^-4)
% szakadasi pont van az intervallumban, nem taltalt megoldast
% erre nem jar zh-ban pont
% rosszul adtuk meg az intervallumot


% Newton modszer
newton(@gf2,@dgf2,10^-4)
% kezdopont: 1, 2 lepes, megoldas: 4.0024
% kezdopont: 0, nem valid futtatas
% kezdopont: 2, 8 lepes, megoldas: 23.0327


% szelo modszer
szelo(@gf2, -1, 5, 10^-4)
% 7 lepes, megoldas: -8.6736
