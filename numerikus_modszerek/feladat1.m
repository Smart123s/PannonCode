3+2;
a=3;
b=2;
a+b

c=input("Kérem a C értékét: ")


%%függvények
log2(5)

%% közelítő értékekkel számol a matlab, ezért van értelmezve
tan(pi/2)

%%
x=1
exp(x) % e^x

%% saját függvény
syms x;
f(x) = x^2-3*x-4;
g = x^2-3*x-4

f(2)

fgv1(0)

x=-5:0.01:5;
y=fgv1(x);
plot(x,y)

ax = gca();
ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.XLim = [-5;5];
ax.YLim = [-10;10];
