using System.ComponentModel.DataAnnotations.Schema;

namespace Construction.Entities;

[Table("Materials")]
public class Material
{

    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public int Quantity { get; set; } = 0;
    public decimal UnitPrice { get; set; } = 0;

}