namespace ConsoleApp1;

// Pannon Egyetem Ismeretek Előzetes Ellenőrzése 2023 Programozás II. Mintafeladat megoldása

// https://mik.uni-pannon.hu/docs/ismell/230814-programozas-ii-mintafeladatsor.pdf
// https://mik.uni-pannon.hu/docs/ismell/230814-programozas-ii-mintafeladatsor.pdf

class ConsoleApp1
{
    static void Main()
    {
        Szineslap s1 = new Szineslap("kor", "zold", "piros");
        Console.WriteLine(s1.Alak + " " + s1.Szin + " " + s1.Masikszin);
        Console.WriteLine(s1.Megfelel("negyzet", "fekete"));
        Console.WriteLine(s1.Megfelel("negyzet", "zold"));
        Console.WriteLine(s1.Megfelel("haromszog", "piros"));
        Console.WriteLine(s1.Megfelel("kor", "zold"));
        Kartyalap k1 = new Szineslap("haromszog", "feher", "fekete");
        Console.WriteLine(k1.Alak + " " + k1.Szin);
        Console.WriteLine(k1.Megfelel("negyzet", "fekete"));
        Console.WriteLine(k1.Megfelel("negyzet", "feher"));
        Console.WriteLine(k1.Megfelel("haromszog", "piros"));
        Console.WriteLine(k1.Megfelel("kor", "zold"));

        Figuraslap f1 = new Figuraslap("kor", "zold", "negyzet");
        Console.WriteLine(f1.Alak + " " + f1.Szin + " " + f1.Masikalak);
        Console.WriteLine(f1.Megfelel("negyzet", "fekete"));
        Console.WriteLine(f1.Megfelel("negyzet", "zold"));
        Console.WriteLine(f1.Megfelel("haromszog", "zold"));
        Console.WriteLine(f1.Megfelel("kor", "zold"));
        Kartyalap k2 = new Figuraslap("haromszog", "sarga", "kor");
        Console.WriteLine(k2.Alak + " " + k2.Szin);
        Console.WriteLine(k2.Megfelel("negyzet", "fekete"));
        Console.WriteLine(k2.Megfelel("negyzet", "sarga"));
        Console.WriteLine(k2.Megfelel("haromszog", "sarga"));
        Console.WriteLine(k2.Megfelel("kor", "sarga"));
        Console.WriteLine(Kartyalap.Darab);

        Jatekos j1 = new Jatekos("zold");
        Console.WriteLine(j1.Szin);
        Console.WriteLine(j1.Meret);
        j1.AddLap(new Szineslap("kor", "zold", "piros"));
        j1.AddLap(new Figuraslap("kor", "zold", "negyzet"));
        j1.AddLap(new Szineslap("haromszog", "feher", "fekete"));
        j1.AddLap(new Figuraslap("haromszog", "sarga", "kor"));
        Console.WriteLine(j1.Meret);
        Console.WriteLine(j1);
        Console.WriteLine(j1.Egyezok("haromszog"));
        Console.WriteLine(j1.Egyezok("negyzet"));

        Jobbjatekos j2 = new Jobbjatekos("zold", "feher");
        Console.WriteLine(j2.Szin + " " + j2.Masikszin);
        Console.WriteLine(j2.Meret);
        j2.AddLap(new Szineslap("kor", "zold", "piros"));
        j2.AddLap(new Figuraslap("kor", "zold", "negyzet"));
        j2.AddLap(new Szineslap("haromszog", "feher", "fekete"));
        j2.AddLap(new Figuraslap("haromszog", "sarga", "kor"));
        Console.WriteLine(j2.Meret);
        Console.WriteLine(j2);
        Console.WriteLine(j2.Egyezok("haromszog"));
        Console.WriteLine(j2.Egyezok("negyzet"));
        Console.WriteLine(~j2);
        Console.WriteLine(~new Jobbjatekos("piros", "piros"));

        //Console.ReadLine();
    }

/* Minta kimenet:

kor zold piros
False
True
True
False
haromszog feher
True
True
False
False
kor zold negyzet
False
False
True
False
haromszog sarga
False
True
False
False
4
zold
0
4
Tarolt lapok szama: 4
Szineslap, alak: kor, szin: zold, masikszin: piros
Figuraslap, alak: kor, szin: zold, masikalak: negyzet
Szineslap, alak: haromszog, szin: feher, masikszin: fekete
Figuraslap, alak: haromszog, szin: sarga, masikalak: kor

2
1
zold feher
0
4
Tarolt lapok szama: 4
Szineslap, alak: kor, szin: zold, masikszin: piros
Figuraslap, alak: kor, szin: zold, masikalak: negyzet
Szineslap, alak: haromszog, szin: feher, masikszin: fekete
Figuraslap, alak: haromszog, szin: sarga, masikalak: kor

2
2
False
True
*/
}