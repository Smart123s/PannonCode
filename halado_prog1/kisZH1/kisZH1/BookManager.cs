using System.Data;
using System.Text.Json;

namespace kisZH1
{
    internal class BookManager
    {
        private List<Book> _books = new List<Book>();
        private Dictionary<string, List<Book>> _byAuthor = new Dictionary<string, List<Book>>();

        public void LoadData(string filePath)
        {
            var content = File.ReadAllText(filePath);
            var result = JsonSerializer.Deserialize<List<Book>>(content);
            _books.AddRange(result);

            _byAuthor = result.GroupBy(tr => tr.Author)
                    .ToDictionary(g => g.Key, g => g.ToList());
        }

        public Book MostExpensive()
        {
            if (_books.Count == 0)
            {
                return null;
            }

            List<Book> SortedList = _books.OrderBy(o => o.Price).ToList();
            return SortedList[SortedList.Count - 1];
        }

        public void AuthorSold()
        {
            foreach (var item in _byAuthor)
            {
                int sum = item.Value.Sum(o => o.CopiesSold);
                Console.WriteLine("Szerző neve: " + item.Key + ", összes eladott példány: " + sum);
            }
        }

        public void AuthorIncome()
        {
            Dictionary<string, float> dict = new Dictionary<string, float>();
            foreach (var item in _byAuthor)
            {
                float sum = item.Value.Sum(o => o.Price * o.CopiesSold);
                dict.Add(item.Key, sum);
            }

            var sortedDict = from entry in dict orderby -entry.Value ascending select entry;

            foreach (var item in sortedDict)
            {
                string sum_formatted = formatFloat(item.Value);
                Console.WriteLine("Szerző neve: " + item.Key + ", összes árbevétel: " + sum_formatted + "Ft");
            }

            
        }

        public static string formatFloat(float value)
        {
            // ha a lentebbi megoldás nem jó, akkor ez is van, csak kicsit máshogy néz ki, mint a minta
            // string sum_formatted = string.Format("{0:N}", item.Value);

            // így olyan mint a minta, csak kicsit spagetti a sok replace miatt
            // ha a ToString-ben a formatot írtam át, az megzavarta
            // Gondolom magyar locale-vel amúgy nem is kéne ezzel szenvedni
            // (a géptermi gép US-re van állítva)
            return value.ToString("#,##0.00").Replace(',', ' ').Replace('.', ',');
        }
    }
}
