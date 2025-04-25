namespace Construction.Entities;

public class ConstructionSite
{
    public int Id { get; set; }
    public string Location { get; set; } = null!;
    public DateTime StartDate { get; set; }
    public DateTime EstimatedEndDate { get; set; }
    public decimal TotalContractCost { get; set; } = 0;

    // Feladat 6 -- átnevezve, mert már meg volt oldva
    public decimal MyTotalContractCost { get; set; } = 0;
    public ICollection<Contract> Contracts { get; set; } = new List<Contract>();
    public ICollection<Material> Materials { get; set; } = new List<Material>();

    public override string ToString()
    {
        return $"{Id}: {Location} {StartDate} {EstimatedEndDate} {TotalContractCost}";
    }
}