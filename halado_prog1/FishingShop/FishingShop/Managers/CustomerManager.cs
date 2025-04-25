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

        public List<Customer> GetAll()
        {
            return _context.Customers.ToList();
        }

        public void UpdateOrderCounts()
        {
            var customers = _context.Customers.ToList();
            foreach (var customer in customers)
            {
                customer.TotalOrders = _context.Orders.Count(o => o.CustomerId == customer.Id);
            }
            _context.SaveChanges();

        }
    }
}
