namespace ConsoleApp1;

public class Jatekos
{
    protected List<Kartyalap> lapok { get; private set; }
    public string Szin { get; }

    public Jatekos(String Szin)
    {
        this.Szin = Szin;
        this.lapok = new List<Kartyalap>();
    }

    public int AddLap(Kartyalap kartya)
    {
        lapok.Add(kartya);
        return lapok.Count;
    }

    public int Meret
    {
        get
        {
            return lapok.Count;
        }
    }
    
    public virtual int Egyezok(string Alak)
    {
        int c = 0;
        foreach (var lap in lapok)
        {
            if (lap.Megfelel(Alak, this.Szin))
            {
                c++;
            }
        }

        return c;
    }

    public override string ToString()
    {
        string ks = "";
        foreach (var lap in lapok)
        {
            ks += lap + "\n";
        }

        return "Tarolt lapok szama: " + this.Meret + "\n" + ks;
    }
}