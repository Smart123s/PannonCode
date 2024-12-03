using FishingShop.Entities;

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
    }
}
