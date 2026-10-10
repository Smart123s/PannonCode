# Product MMix: Bakery of Cakes

set Products;
set Resources;

param Available_Resources {r in Resources};
param Product_Price {p in Products};
param Required_Resources {r in Resources, p in Products}, default 0;

var x {p in Products}, >=0 integer;

s.t. Used_Resource_Constraint {r in Resources}:
	sum {p in Products} Required_Resources[r,p] * x[p] <= Available_Resources[r];

maximize Revenue:
	sum{p in Products} x[p] * Product_Price[p];

solve;

printf "TotalValue=%g\n", Revenue;

for {p in Products}
{
	printf "Product %s -> %g units\n",p, x[p]; 
}

for {r in Resources}
{
	printf "Remaining resource %s -> %g units\n",r, Available_Resources[r] - sum {p in Products} Required_Resources[r,p] * x[p]; 
}

# here ends the model section
data;
# now here comes the data section
# -> contains only instance data
# -> much more flexible syntax

set Products := Cake1 Cake2 Cake3 Cake4 Cake5;
set Resources := Flour Butter Sugar Eggs;

param Available_Resources :=
	Flour	50000
	Butter	5000
	Sugar	30000
	Eggs	100
	;

param Product_Price :=
	Cake1	7
	Cake2	7
	Cake3	8
	Cake4	9
	Cake5	11
	;

param Required_Resources :
			Cake1	Cake2	Cake3	Cake4	Cake5 :=
	Flour	300	400	1360	550	600
	Butter	200	150	250	280	300
	Sugar	100	0	250	280	350
	Eggs	3	6	5	6	8
	;

# Another method (work on non 2d arrays too)
#param Required_Resources :=
#	Flour	Cake1	300
#	...

end;
