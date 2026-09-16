# Sandwich making problem

# 2) dh requires 3 slices of bread instead of 2

var b >=0, integer;
var h >=0, integer;
var dh >=0, integer;

s.t. Bread_limit:
	2*b + 2*h + 3*dh <= 100;

s.t. Ham_limit:
	h + dh*2<= 30; # but also easy as a bound (for this problem)

maximize TotalValue:
	3*b + 4*h + 7*dh;

solve;

printf "TotalValue=%g\n", TotalValue;
printf "Buttery: %g\n", b;
printf "Ham: %g\n", h;
printf "Double Ham: %g\n", dh;
printf "Bread used: %g\n", 2*b + 2*h + 3*dh;
