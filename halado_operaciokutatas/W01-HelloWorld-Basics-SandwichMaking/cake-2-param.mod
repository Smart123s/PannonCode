# Product MMix: Bakery of Cakes

# 2) dh requires 3 slices of bread instead of 2

var c1 >=0, integer;
var c2 >=0, integer;
var c3 >=0, integer;
var c4 >=0, integer;
var c5 >=0, integer;

# Slack variables from the primal simplex methods
#auxilary variables (variables, but no more freedom in the model)
var remaining_f >= 0;
var remaining_b >= 0;
var remaining_s >= 0;
var remaining_e >= 0;

param Available_Flour := 50000;
param Available_Sugar := 30000;
param Available_Butter := 5000;
param Available_Egg := 100;

param Cake1_Price := 6;
param Cake2_Price := 7;

s.t. Flour_limit:
	300*c1 + 400*c2 + 360*c3 + 550*c4 + 600*c5 + remaining_f = Available_Flour;

s.t. Sugar_limit:
	100*c1 + 250*c3 + 280*c4 + 350*c5 + remaining_s = Available_Sugar;

s.t. Butter_limit:
	200*c1 + 150*c2 + 250*c3 + 280*c4 + 300*c5 + remaining_b = Available_Butter;

s.t. Egg_limit:
	3*c1 + 6*c2 + 5*c3 + 6*c4 + 8*c5 + remaining_e = Available_Egg;

maximize TotalValue:
	Cake1_Price*c1 + Cake2_Price*c2 + 8*c3 + 9*c4 + 11*c5;

solve;

printf "TotalValue=%g\n", TotalValue;
printf "Cake1: %g\n", c1;
printf "Cake2: %g\n", c2;
printf "Cake3: %g\n", c3;
printf "Cake4: %g\n", c4;
printf "Cake5: %g\n", c5;
printf "Flour used: %g\n", Flour_limit;
printf "Sugar used: %g\n", Sugar_limit;
printf "Butter used: %g\n", Butter_limit;
printf "Egg used: %g\n", Egg_limit;

printf "Remaining Flour: %g\n", remaining_f;
printf "Remaining Sugar: %g\n", remaining_s;
printf "Remaining Butter: %g\n", remaining_b;
printf "Remaining Egg: %g\n", remaining_e;

# here ends the model section
data;
# now here comes the data section
# -> contains only instance data
# -> much more flexible syntax
