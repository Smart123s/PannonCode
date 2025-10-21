$title ZH 2023 parctice at home

$onText
$offText

Set
   i 'gyar' / 1*4 /
   j 'bolt' / 1*5 /;

Parameter
   a(i) 'capacity of plant/gyar i in cases'
        / 1 35,
          2 45,
          3 92,
          4 29 /

   b(j) 'demand at market/bolt j in cases'
        / 1 13,
          2 11,
          3 13,
          4 10,
          5 14 /
          
    e(i) 'egyszeri koltseg'
        / 1 93,
          2 48,
          3 87,
          4 68 /
;

Table d(i,j) 'distance in thousands of miles'
   1  2  3  4  5
1  4  3  2  4  5
2  1  2  3  1  4
3  1  4  1  2  5
4  3  4  5  7  9
;


Parameter c(i,j) 'transport cost per case';
c(i,j) = d(i,j);

Variable
   x(i,j) 'shipment quantities in cases'
   z      'total transportation costs';

Binary Variable
   y(i)   '1, ha az i-edik gyarbol szallitunk, 0 kulonben';

Positive Variable x;

Equation
   cost      'define objective function'
   supply(i) 'observe supply limit at plant i'
   demand(j) 'satisfy demand at market j';

cost..      z =e= sum((i,j), c(i,j)*x(i,j)) + sum(i, e(i)*y(i));

* Ha y(i)=0, akkor nem lehet onnan szallitani, tehat supply = 0
supply(i).. sum(j, x(i,j)) =l= a(i) * y(i);

demand(j).. sum(i, x(i,j)) =g= b(j);

Model transport / all /;

solve transport using mip minimizing z;

display x.l, y.l, x.m;
