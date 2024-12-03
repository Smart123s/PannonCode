using NagyZHPractice;

public class Repair
{
    public int Id { get; set; }
    public DateOnly Date { get; set; }
    public string Description { get; set; } = "";
    public Car Car { get; set; }
}
