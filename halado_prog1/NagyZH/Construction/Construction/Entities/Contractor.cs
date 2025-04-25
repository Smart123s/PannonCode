namespace Construction.Entities;

public class Contractor
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string PhoneNumber { get; set; } = null!;
    public ICollection<Contract> Contracts { get; set; } = new List<Contract>();

    public override string ToString()
    {
        return $"{Id}: {Name} {Email} {PhoneNumber}";
    }
}