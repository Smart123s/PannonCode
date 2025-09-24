$title Termelesi problema / A Production Problem (PRODUCTION,SEQ=1)

$onText
Ide kell majd nev, neptun kod, eredmeny, hogy szerintunk jo-e
$offText

Set
   i 'eroforras' / 1*4 /
   j 'termekek'  / 1*5/;

Parameter
   b(i) 'capacity' / 1 28, 2 34, 3 42, 4 18 /

   c(j) 'haszon' / 1 18,
                   2 43,
                   3 25,
                   4 19,
                   5 61 /
;

Table a(i,j) 'termelesi egyutthatok'
  1 2 3 4 5
1   1 2   4
2 2   3 1 1
3 1 1 1   5
4 2     3 2
;

Variable
   x(j) 'ennyit gyartottunk'
   z      'total cost';

Positive Variable x;

Equation
   cost      'define objective function'
   supply(i) 'kapacitastnem lephetjuk tul'
;

cost..      z =e= sum(j, c(j)*x(j));

supply(i).. sum(j, a(i,j)*x(j)) =l= b(i);

Model production / all /;

solve production using lp maximizing z;

display x.l, z.l;
