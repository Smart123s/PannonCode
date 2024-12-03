namespace FishingShop.Entities
{
    public class Product
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Category { get; set; } = string.Empty;
        public double Price { get; set; }

        public ICollection<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();

        public override string ToString() => $"{ProductId}: {Name} ({Category}) - {Price} Ft";
    }
}