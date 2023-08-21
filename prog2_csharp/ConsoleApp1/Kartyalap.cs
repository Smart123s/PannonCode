using System.Runtime.CompilerServices;

namespace ConsoleApp1;

public abstract class Kartyalap
{
    public string Alak { get; }
    public string Szin { get; }
    private static int _Darab = 0;

    protected Kartyalap(string Alak, string Szin)
    {
        this.Alak = Alak;
        this.Szin = Szin;
        _Darab++;
    }

    public abstract bool Megfelel(string Alak, string Szin);

    public override string ToString()
    {
        return this.GetType() + ", alak: " + Alak + ", szin: " + Szin;
    }

    public static int Darab
    {
        get { return _Darab; }
    }
}