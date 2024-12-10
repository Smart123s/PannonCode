using Construction.Entities;

namespace Construction.Managers
{
    internal class ContractorManager
    {
        private readonly ConstructionDbContext _context;

        public ContractorManager(ConstructionDbContext context)
        {
            _context = context;
        }

        public void Create(Contractor contractor)
        {
            _context.Contractors.Add(contractor);
            _context.SaveChanges();
        }

        public IList<Contractor> GetAll()
        {
            return _context.Contractors.ToList();
        }

        public Dictionary<Contractor, decimal> costInLast30Days()
        {
            return _context.Contracts
                .Where(o => o.SignedDate >= DateTime.Today.AddDays(-30))
                .GroupBy(o => o.Contractor)
                .ToDictionary(o => o.Key, o => o.Sum(o => o.Cost));
        }
    }
}
