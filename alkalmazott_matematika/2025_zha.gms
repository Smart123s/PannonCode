$title ZH 2023 parctice at home

$onText
Nev: Tombor Peter
Neptun: A9XXGK

Feladat kiertekelese:
            1           2           3           4           5
1                                          20.000       6.000
2      39.000      52.000
3                              44.000                  45.000
4      34.000                  26.000

Telephely 1 -> Bolt 4: 20db termek
Telephely 1 -> Bolt 5: 6db termek
Telephely 2 -> Bolt 1: 39db termek
Telephely 2 -> Bolt 2: 52db termek
Telephely 3 -> Bolt 3: 44db termek
Telephely 3 -> Bolt 5: 45db termek
Telephely 4 -> Bolt 1: 34db termek
Telephely 4 -> Bolt 3: 26db termek

Osszes koltseg: 1270

$offText

Set
   i 'gyar' / 1*4 /
   j 'bolt' / 1*5 /;

Parameter
   a(i) 'capacity of plant/gyar i in cases'
        / 1 26,
          2 91,
          3 89,
          4 60 /

   b(j) 'demand at market/bolt j in cases'
        / 1 73,
          2 52,
          3 70,
          4 20,
          5 51 /
;

Scalar fix_koltseg 'egyszeri inditasi koltseg' / 100 /;

Table d(i,j) 'tablazat a feladatbol'
   1  2  3  4  5
1  5  8  7  4  5
2  1  1  3  1  4
3  1  4  1  2  1
4  3  4  3  7  9
;

Parameter c(i,j) 'transport cost per case';
c(i,j) = d(i,j);

Variable
   x(i,j) 'shipment quantities in cases'
   z      'total transportation costs';

Binary Variable
   y(i,j)   'y(i,j) == 1 ha szallitunk ij kozott, kulonben 0';

Positive Variable x;

Equation
   cost      'define objective function'
   supply(i) 'observe supply limit at plant i'
   demand(j) 'satisfy demand at market j'
   bigm(i,j) 'csak akkor kell fix koltseg, ha szallitunk is';

cost..      z =e= sum((i,j), c(i,j)*x(i,j) + y(i,j)*fix_koltseg);

supply(i).. sum(j, x(i,j)) =l= a(i);

demand(j).. sum(i, x(i,j)) =g= b(j);

* miel a a kapacitas, ezert annal nagyobb tuti nem lehet a szallitott mennyiseg
bigm(i,j).. x(i,j) =l= y(i,j)*a(i);

Model transport / all /;

solve transport using mip minimizing z;

display z.l, x.l, y.l;
