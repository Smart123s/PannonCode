$title A Transportation Problem (TRNSPORT,SEQ=1)

$onText

$offText

Set
   i 'telephely' / 1*4 /
   j 'lerakohely' / 1*5 /;

Table d(i,j) 'shzallitasi eyógyseg koltseg'
  1  2  3  4  5
1 4  3  2  4  5
2 1  2  3  1  4
3 1  4  1  2  5
4 3  4  5  7  9
;

Parameter
   keszl(i) 'keszlet'
        / 1 17, 2 21, 3 19, 4 23 /

   akp(j) 'kapacitás'
        / 1 13, 2 51, 3 73, 4 20, 5 44/
    
   ind(j) / 1 46, 2 58, 3 63, 4 97, 5 28 /


Variable
   x(i,j) 'honnan hova mennyit viszunk'
   u(j)   'viszunk oda vagy sem'
   z      'tosszkoltseg';

Positive Variable x;
Binary variable u;

Equation
   cost      'osszes koltseg'
   mindent(i) 'omindent el kell szallitani soronkent'
   legfeljebb(j) 'legfeljebb ennyit vihezunk oszloponkent'
    kell(j) 'ha viszunk valahva akkor u legyen egy';

cost..      z =e= sum((i,j), c(i,j)*x(i,j))
                  + sum(j, u(j)*ind(j));

mindent.. sum(j, x(i,j)) =l= keszlet(i);

legfeljebb(j).. sum(i, x(i,j)) =g= kap(j);

kell(j)..    sum(i, x(i,j) =l= M*u(j);

Model transport / all /;

solve transport using mlp minimizing z;

display u.l, z.l;
