$title negyzetek

$ontext
18 novekvo negyzetet akarunk elpakolni a leheto legkisebb negyzetbe

$offtext

set i /1*12/ ;
alias (i,j);
*n=15-re min=36, hamar megvan
*
*n=16-re min=39, 302 sec
*n=16, ha rogzitem hogy a 15-ostol jobbra van a 16-os: 250 sec
*n=16, ha meg azt is rogzitem hogy x <=36 es y <= 32 (amit onnet olvastam ki amikor ez nincs rogzitve de ilyen megoldast talat) 57 sec.
*
*n=17-re min=43:  336 sec utan megtalalja a 43-as megoldast, de meg eltart egy darabig amig kizarja a 42-ot. Rogzitettuk hogy a 16-ostol jobra van a 17-es.
*                 1890 sec utan van vege.  
*
*n=18-re min=47: 108 sec alatt megtalalja a 47-et, de tovabb tart amig kizarja hogy kisebb is lehet. 2000 sec nem eleg!
*
*kiegeszitettem most azzal, hogy egy negyzet egy masiktol nem lehet jobbra is es balra is:
* igy 41 sec alatt talalja meg a 47-es megoldast (de fut tovabb)
*
*ha meg azzal is hogy alatta es folotte sem lehet egyszerre, kesobb tala 47-es megoldast (es fut tovabb)

parameter s(i) 'negyzetek nagysaga';
s(i)= ord(i);

variable  x(i), y(i), jobbra(i,j), alatt(i,j), z;

binary variables jobbra, alatt;
positive variable x,y;
*x(i)=a negyzet bal felso sarka x koordinataja
*y(i)=a negyzet bal felso sarka y koordinataja
*jobbra(i,j)=1, ha az  i. negyzettol jobbra van a j. negyzet
*alatt(i,j)=1,  ha az  i. negyzet alatt van a j. negyzet

scalar M nagy szám /1000/;

*x.up(i)=36;
*y.up(i)=32;
*jobbra.fx("17","18")=1;

equations
horizontal(i,j),
vertical(i,j),
valahol(i,j),
legalabb1(i),
legalabb2(i),
kizaro1(i,j),
kizaro2(i,j)
;
*
horizontal(i,j)$( ord(i) <> ord(j) )..   x(i) +s(i)   =l= x(j) + M*(1-jobbra(i,j));
vertical(i,j)$(ord(i) > ord(j) OR ord(i) < ord(j) )..     y(i) +s(i)   =l= y(j) + M*(1-alatt(i,j));
*ugy is jo hogy <> ugy is jo hogy > OR <
valahol(i,j)$(ord(i) > ord(j) OR ord(i) < ord(j))..   jobbra(i,j)+jobbra(j,i) + alatt(i,j)+alatt(j,i) =g= 1;
legalabb1(i)..     z =g= x(i)+s(i);
legalabb2(i)..     z =g= y(i)+s(i);
kizaro1(i,j)$( ord(i) <> ord(j) )..     jobbra(i,j)+jobbra(j,i) =l=1;
kizaro2(i,j)$( ord(i) <> ord(j) )..     alatt(i,j)+alatt(j,i) =l=1;

model square / all /;

*option nlp=minos;
*option MIP=XPRESS;

*option optca = 1E-12;
*option optcr = 0.000001;
solve square minimizing z using mip;

display x.l,y.l ;