namespace FishingShop.Managers
{
    public class ProductManager
    {
        private readonly FishingShopDbContext _context;

        public ProductManager(FishingShopDbContext context)
        {
            _context = context;
        }
    }
}
