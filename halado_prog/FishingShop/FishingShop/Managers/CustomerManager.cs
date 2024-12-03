namespace FishingShop.Managers
{
    public class CustomerManager
    {
        private readonly FishingShopDbContext _context;

        public CustomerManager(FishingShopDbContext context)
        {
            _context = context;
        }
    }
}
