namespace FishingShop.Entities
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public int TotalOrders { get; set; } = 0;


        public ICollection<Order> Orders { get; set; } = new List<Order>();
        
        public override string ToString() => $"{Name} {Email} (Total: {TotalOrders})";
    }
}