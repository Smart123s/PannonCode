using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop.Managers
{
    public class ProductManager
    {
        private readonly FishingShopDbContext _context;

        public ProductManager(FishingShopDbContext context)
        {
            _context = context;
        }

        public void Create(Product product)
        {
            _context.Products.Add(product);
            _context.ToString();
        }

        public IList<Product> GetAll()
        {
            return _context.Products.ToList();
        }

        public Dictionary<string, List<string>> GetCustomers()
        {
            return _context.Products
                .Include(p => p.OrderProducts)
                .ThenInclude(op => op.Order)
                .ThenInclude(o => o.Customer)
                .GroupBy(product => product.Name)
                .ToDictionary(Customer => Customer.Key, Customer
                    => Customer.SelectMany(product => product.OrderProducts.Select(op => op.Order.Customer.Name)).Distinct().ToList());
        }
    }
}
