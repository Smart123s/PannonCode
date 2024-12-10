namespace Construction.Entities;

public class Contract
{
    public int Id { get; set; }
    public string Description { get; set; } = null!;
    public decimal Cost { get; set; }
    public DateTime SignedDate { get; set; }
    public int ContractorId { get; set; }
    public Contractor Contractor { get; set; } = null!;
    public int ConstructionSiteId { get; set; }
    public ConstructionSite ConstructionSite { get; set; } = null!;
}