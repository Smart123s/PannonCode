using static System.Formats.Asn1.AsnWriter;
using System.Collections.Generic;

namespace KisZH1Parctice;

   internal class Program
{
    static void Main(string[] args)
    {
        var manager = new TestResultManager();
        manager.LoadData("testresults.json");
        Console.WriteLine("Scores loaded\n");

        // Feladat 1
        Console.WriteLine("Finding scores:");

        try
        {
            Console.WriteLine("Score with at least 80 points under 25 minutes:");
            Console.WriteLine("\t" + manager.FindScore(80, 25));
        }
        catch (ArgumentException e) {
            Console.WriteLine("\tError: could not find score: There is no score with required values");
        }

        try
        {
            Console.WriteLine("Score with at least 90 points under 15 minutes:");
            Console.WriteLine("\t" + manager.FindScore(90, 15));
        }
        catch (ArgumentException e)
        {
            Console.WriteLine("\tError: could not find score: There is no score with required values");
        }

        Console.WriteLine("");

        // Feladat 2
        Console.WriteLine("Average scores:");
        manager.PrintAverages();
    }
}
