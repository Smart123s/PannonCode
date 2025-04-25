namespace NagyZHPractice
{
    public class Car 
    {
        public int Id { get; set; }
        public string Type { get; set; } = "";
        public string PlateNumber { get; set; } = "";
        public Owner? Owner { get; set; }
        public List<Repair> Repairs { get; set; } = new List<Repair>();
        
    }
}
