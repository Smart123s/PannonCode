namespace NagyZHPractice
{
    public class Owner 
    { 
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public string? Address { get; set; }
        public List<Car> Cars { get; set; } = new List<Car>();
    }
}
