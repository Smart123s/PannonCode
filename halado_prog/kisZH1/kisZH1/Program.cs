namespace kisZH1;

internal class Program
{
    static void Main(string[] args)
    {
        var manager = new BookManager();
        manager.LoadData("bookstore.json");
        Console.WriteLine("Sikeres adatbetöltés\nAdatbetöltés vége\n");

        // feladat 1
        Console.WriteLine("1. Feladat: Legdrágább könyv keresése");
        Book m = manager.MostExpensive();
        Console.WriteLine("Legdrágább könyv: " + m.Title + ", Ár: " + BookManager.formatFloat(m.Price));

        // feladat 2
        Console.WriteLine("----------\n");
        Console.WriteLine("2. Feladat: Szerzők összesített eladásai");
        manager.AuthorSold();

        // feladat 3
        Console.WriteLine("----------\n");
        Console.WriteLine("3. Feladat: Legnagyobb árbevételű szerzők");
        manager.AuthorIncome();

    }
}