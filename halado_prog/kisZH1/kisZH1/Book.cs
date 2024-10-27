namespace kisZH1
{
    public class Book
    {
        // Bocsi, ez nem működött, ha nem tettem publikussá
        // A JSON deserializer vinnyogott
        // Gondolom ezért írtuk órán egy fileba a két Classt
        public string Title { get; set; }
        public string Author { get; set; }
        public float Price { get; set; }
        public int CopiesSold {  get; set; }

        public Book(string Title, string Author, float Price, int CopiesSold)
        {
            this.Title = Title;
            this.Author = Author;
            this.Price = Price;
            this.CopiesSold = CopiesSold;
        }
    }
}
