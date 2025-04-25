using Construction.Entities;
using Construction.Managers;

namespace Construction;

public class Program
{
    public static void Main(string[] args)
    {
        var context = new ConstructionDbContext();
        var contractManager = new ContractManager(context);
        var constructionSiteManager = new ConstructionSiteManager(context);
        var contractorManager = new ContractorManager(context);

        if (false && contractorManager.GetAll().Count < 0)
        {
            contractorManager.Create(new Contractor()
            {
                Name = "Sanyi",
                Email = "sanyi@uni-pannon.hu",
                PhoneNumber = "1234567890",
                Contracts = new List<Contract>()
                {
                    /*
                     * SqlException: Cannot insert explicit value for identity column in table 'Contracts'
                     * when IDENTITY_INSERT is set to OFF.
                    */
                    //new Contract(){ Id=1}
                }
            });
            contractorManager.Create(new Contractor()
            {
                Name = "Bela",
                Email = "sbela@uni-pannon.hu",
                PhoneNumber = "999999999999",
                Contracts = new List<Contract>()
                {
                    //new Contract(){ Id=2},
                    //new Contract(){ Id=3}
                }
            });

            constructionSiteManager.Create(new ConstructionSite()
            {
                Location = "Veszprem",
                StartDate = DateTime.Now,
                EstimatedEndDate = DateTime.Now,
                TotalContractCost = 100,
                Contracts = new List<Contract>()
                {
                    //new Contract() { Id = 1 }
                }
            });

        }

        Console.WriteLine("\nContractors:");
        contractorManager.GetAll().ToList().ForEach(Console.WriteLine);

        //Console.WriteLine("Contracts:");
        //Console.WriteLine(contractManager.GetAll());

        Console.WriteLine("\nConstructionSites:");
        constructionSiteManager.GetAll().ToList().ForEach(Console.WriteLine);

        // feladat 2
        Console.WriteLine("\nFeladat2:");
        foreach (var c in constructionSiteManager.numberOfContracts()) {
            Console.WriteLine(c.Key.Location + ": " + c.Value);
        }

        // feladat 3
        contractManager.AddContractToSite(
            new ConstructionSite() { Id = 2 },
            new Contract() { 
                Cost = 10,
                Description = "Yey",
                ContractorId = 3,
            }
            );

        // feladat 4
        try
        {
            contractManager.Create(new Contract()
            {
                Cost = 20,
                Description = "AAAAAAAAAAAAA",
                ContractorId = 1,
                ConstructionSiteId = 1,
            });
        } catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }

        // feladat 5
        Console.WriteLine("\nFeladat5:");
        Console.WriteLine("A minta adatban nincs szerződéskötés az elmúlt 30 napból");
        foreach (var c in contractorManager.costInLast30Days())
        {
            Console.WriteLine(c.Key.Name + ": " + c.Value);
        }

        // feladat 6
        // ConstructionSite.cs és Migration file
        // a Property át lett nevezme, mert a feladat által kért már foglalt volt :)

        // feladat 7
        Console.WriteLine("\nFeladat7:");
        foreach (var c in constructionSiteManager.getCostForSite())
        {
            Console.WriteLine(c.Key.Location + ": " + c.Value);
        }
    }
}