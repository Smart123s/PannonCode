using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace FishingShop.Managers
{
    public class OrderManager
    {
        private readonly FishingShopDbContext _context;
        private readonly IList<string> _blackListedCustomerNames;

        public OrderManager(FishingShopDbContext context)
        {
            _context = context;
            var fileContent = File.ReadAllText("blacklist.json");
            _blackListedCustomerNames = JsonSerializer.Deserialize<IList<string>>(fileContent);
        }

        public List<Order> GetAll()
        {
            return _context.Orders
                .Include(o => o.Customer)
                .OrderBy(o => o.OrderDate)
                .ToList();
        }

        public void Create(Order order)
        {
            var customerName = _context.Customers
                .Where(customer => customer.Id == order.CustomerId)
                .Select(Customer => Customer.Name)
                .First();

            if (_blackListedCustomerNames.Contains(customerName))
            {
                throw new BlackListException(customerName);
            }
            _context.Orders.Add(order);
            _context.SaveChanges();
        }

        public Dictionary<DateTime, int> GetOrderCountByDate()
        {
            return _context.Orders
                .GroupBy(o => o.OrderDate)
                .ToDictionary(g => g.Key, g => g.Count());
        }
    }
}
