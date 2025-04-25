using Construction.Entities;
using Construction.Exceptions;
using System.Text.Json;

namespace Construction.Managers
{
    internal class ContractManager
    {
        private readonly ConstructionDbContext _context;
        public ContractManager(ConstructionDbContext context)
        {
            _context = context;
        }

        public void Create(Contract contract)
        {
            var blacklist = GetBlacklist();
            var contractor = _context.Contractors.FirstOrDefault(c => c.Id == contract.ContractorId);
            if (blacklist.Contains(contractor?.Name))
            {
                throw new BlacklistException(contractor.Name);
            }

            _context.Contracts.Add(contract);
            _context.SaveChanges();

            // Jó, ez elég csúnya megoldás...
            var constructionSiteManager = new ConstructionSiteManager(_context);
            constructionSiteManager.getCostForSite();
        }

        public IList<Contract> GetAll()
        {
            return _context.Contracts.ToList();
        }

        public void AddContractToSite(ConstructionSite constructionSite, Contract contract)
        {
            // lehet nem lenne muszáj újra lekérni, de a Main-ből csak ID-vel fogom meghívni
            ConstructionSite site = _context.ConstructionSites.Where(o => o.Id == constructionSite.Id).First();
            site.Contracts.Add(contract);
            _context.SaveChanges();
        }

        private static List<string> GetBlacklist()
        {
            var blackListRaw = File.ReadAllText(Path.Combine(Directory.GetCurrentDirectory(), "blacklist.json"));
            return JsonSerializer.Deserialize<List<string>>(blackListRaw) ?? [];
        }
    }
}
