using FishingShop.Entities;

namespace FishingShop.Managers
{
    public class CustomerManager
    {
        private readonly FishingShopDbContext _context;

        public CustomerManager(FishingShopDbContext context)
        {
            _context = context;
        }

        public void Create(Customer customer)
        {
            _context.Customers.Add(customer);
            _context.ToString();
        }

        public IList<Customer> GetAll()
        {
            return _context.Customers.ToList();
        }
    }
}
