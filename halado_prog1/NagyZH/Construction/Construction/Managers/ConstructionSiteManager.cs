using Construction.Entities;
using Microsoft.EntityFrameworkCore;

namespace Construction.Managers
{
    internal class ConstructionSiteManager
    {
        private readonly ConstructionDbContext _context;
        public ConstructionSiteManager(ConstructionDbContext context)
        {
            _context = context;
        }

        public void Create(ConstructionSite constructionSite)
        {
            _context.ConstructionSites.Add(constructionSite);
            _context.SaveChanges();
        }

        public IList<ConstructionSite> GetAll()
        {
            return _context.ConstructionSites.ToList();
        }

        public Dictionary<ConstructionSite, int> numberOfContracts()
        {
            return _context.Contracts
                //.Include(o => o.ConstructionSite)
                .GroupBy(o => o.ConstructionSite)
                .ToDictionary(o => o.Key, o => o.Count());
        }

        // összes építkezéshez tartozó szerződések költségeit, és elmenti azokat
        public Dictionary<ConstructionSite, decimal> getCostForSite()
        {
            var costs = _context.Contracts
                .GroupBy(o => o.ConstructionSite)
                .ToDictionary(o => o.Key, o => o.Sum(o => o.Cost));

            foreach (var c in costs)
            {
                c.Key.TotalContractCost = c.Value;
            }

            _context.SaveChanges();

            return costs;
        }
    }
}
