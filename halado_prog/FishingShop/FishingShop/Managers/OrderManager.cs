using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop.Managers
{
    public class OrderManager
    {
        private readonly FishingShopDbContext _context;

        public OrderManager(FishingShopDbContext context)
        {
            _context = context;
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
            _context.Orders.Add(order);
            _context.ToString();
        }
    }
}
