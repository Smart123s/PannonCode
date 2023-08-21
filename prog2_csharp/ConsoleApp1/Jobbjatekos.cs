namespace ConsoleApp1;

public class Jobbjatekos : Jatekos
{
    public string Masikszin { get; }
    
    public Jobbjatekos(string Szin, string Masikszin) : base(Szin)
    {
        this.Masikszin = Masikszin;
    }
    
    public override int Egyezok(string Alak)
    {
        int c = 0;
        foreach (var lap in this.lapok)
        {
            if (lap.Megfelel(Alak, this.Szin) || lap.Megfelel(Alak, this.Masikszin))
            {
                c++;
            }
        }

        return c;
    }

    public static bool operator ~(Jobbjatekos jatekos)
    {
        return jatekos.Szin == jatekos.Masikszin;
    }
}