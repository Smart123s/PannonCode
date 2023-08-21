namespace ConsoleApp1;

public class Szineslap : Kartyalap
{
    public string Masikszin { get; }

    public Szineslap(string Alak, string Szin, string Masikszin) : base(Alak, Szin)
    {
        this.Masikszin = Masikszin;
    }
    
    public override bool Megfelel(string Alak, string Szin)
    {
        return this.Alak != Alak && (this.Masikszin == Szin || this.Szin == Szin);
    }

    public override string ToString()
    {
        return base.ToString() + ", masikszin: " + Masikszin;
    }
}