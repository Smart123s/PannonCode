namespace kiszh2
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // JSON fájl beolvasása
            var inputManager = new InputManager("events.json");

            // Feladat 1

            Console.WriteLine("Feladat 1 - Legnépszerűbb rendezvény:");
            Event mostPopular = inputManager.MostPopular();
            Console.WriteLine(mostPopular.Name + " - " + mostPopular.Participants.Count + " résztvevő\n");

            // Feladat 2
            Console.WriteLine("Feladat 2 - Résztvevők, akik legalább 8 különböző eseményen vettek részt:");
            var moreThan8 = inputManager.MoreThan8();
            foreach (var item in moreThan8)
            {
                Console.WriteLine(item.Name + " - " + item.Events.Count + " esemény");
            }

            // Feladat 3
            Console.WriteLine("\nFeladat 3 - Helyszínek átlagos résztvevőszáma:");
            var avgEC = inputManager.AverageEventCount();
            foreach (var item in avgEC)
            {
                Console.WriteLine(item.Key.Name + ": " + formatDouble(item.Value) + " átlagos résztvevő");
            }
        }

        public static string formatDouble(double value)
        {
            // Gondolom a minta output magyar locale-ra állított gépen futtatva
            // A teremben viszont US locale van, és megzavarodik, ha ","-t használok tizedesvesszőnek
            // Ezért a sok replace
            // Biztos van szebb megoldás is...
            return value.ToString("#,##0.00").Replace(',', ' ').Replace('.', ',');
        }
    }

}
