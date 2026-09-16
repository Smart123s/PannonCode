# Transportation problem

# 2 Warehouses:
# - A: 11 goods available
# - B: 10 goods available

# 3 Markets:
# - M1: 13 goods required
# - M2: 5 goods required
# - M3: 2 goods required

# Transportation costs:
# - A->M1: 235$ per unit
# - A->M2: 57$ per unit
# - A->M3: 340$ per unit
# - B->M1: 130$ per unit
# - B->M2: 385$ per unit
# - B->M3: 197$ per unit

var am1, >=0, integer;
var am2, >=0, integer;
var am3, >=0, integer;
var bm1, >=0, integer;
var bm2, >=0, integer;
var bm3, >=0, integer;

s.t. Supply_A: am1 + am2 + am3 <= 11;
s.t. Supply_B: bm1 + bm2 + bm3 <= 10;

s.t. Demand_M1: am1 + bm1 = 13;
s.t. Demand_M2: am2 + bm2 = 5;
s.t. Demand_M3: am3 + bm3 = 2;

minimize Transportation_Costs:
	235*am1 + 57*am2 + 340*am3 + 
	130*bm1 + 385*bm2 + 197*bm3;

solve;

printf "Transportation_Costs == %g\n", Transportation_Costs;
printf "A -> M1 == %g\n", am1;
printf "A -> M2 == %g\n", am2;
printf "A -> M3 == %g\n", am3;
printf "B -> M1 == %g\n", bm1;
printf "B -> M2 == %g\n", bm2;
printf "B-> M3 == %g\n", bm3;

end;
