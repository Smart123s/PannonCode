# Sandwich making problem

# 2) ham limited, max. 30 slices (1 ham sandwich: 1 slice of ham)

var b >=0;
var h >=0;
var dh >=0;

s.t. Bread_limit:
	2*b + 2*h + 2*dh <= 100;

s.t. Ham_limit:
	h + dh*2<= 30; # but also easy as a bound (for this problem)

maximize TotalValue:
	3*b + 4*h + 7*dh;

solve;

printf "TotalValue=%g\n", TotalValue;
printf "Buttery: %g\n", b;
printf "Ham: %g\n", h;
printf "Double Ham: %g\n", dh;
printf "Bread used: %g\n", 2*b + 2*h + 2*dh;
