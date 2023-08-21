namespace ConsoleApp1;

public class Figuraslap : Kartyalap
{
    public string Masikalak { get; }

    public Figuraslap(string Alak, string Szin, string Masikalak) : base(Alak, Szin)
    {
        this.Masikalak = Masikalak;
    }
    
    public override bool Megfelel(string Alak, string Szin)
    {
        return (this.Alak != Alak && this.Masikalak != Alak) &&  this.Szin == Szin;
    }

    public override string ToString()
    {
        return base.ToString() + ", masikalak: " + Masikalak;
    }
}