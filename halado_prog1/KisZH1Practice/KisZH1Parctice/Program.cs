using static System.Formats.Asn1.AsnWriter;
using System.Collections.Generic;
using System.Linq;

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
        Dictionary<string, float> averages = manager.GetAveragesByGroup();
        foreach (var item in averages)
        {
            Console.WriteLine("Average of group " + item.Key + ": " + item.Value);
        }

        Console.WriteLine("");

        // Feladat 3
        Console.WriteLine("Most common grades:");
        // Dictionary<group, Dictionary<grade, count>>
        Dictionary<string, Dictionary<int, int>> grades = manager.GetGrades();
        foreach (var item in grades)
        {
            // get most common grade(s)
            var mostCommon = item.Value.Where(a => a.Value == item.Value.Values.First()).Select(a => a.Key);
            Console.WriteLine("Most common grades in group " + item.Key + " with " + item.Value.Values.First() + " tests : " + string.Join(" ", mostCommon.ToList()));
        }   
    }
}
