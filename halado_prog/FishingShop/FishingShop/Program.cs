﻿using FishingShop.Entities;
using FishingShop.Managers;

namespace FishingShop
{
    public static class Program
    {
        public static async Task Main()
        {
            var context = new FishingShopDbContext();
            var customerManager = new CustomerManager(context);
            var productManager = new ProductManager(context);
            var orderManager = new OrderManager(context);

            //add customers
            if (context.Customers.Count() < 23)
            {
                customerManager.Create(new Customer
                {
                    Email = "nagy.janos@gmail.com",
                    Name = "Nagy János"
                });
                customerManager.Create(new Customer
                {
                    Email = "moldova.gyorgy@gmail.com",
                    Name = "Moldova György"
                });
                customerManager.Create(new Customer
                {
                    Email = "boda.jeno@gmail.com",
                    Name = "Boda Jenő"
                });
            }

            //list customers
            Console.WriteLine("Customers:");
            var customers = customerManager.GetAll();
            customers.ToList().ForEach(Console.WriteLine);
            Console.WriteLine();

            //add products
            if (context.Products.Count() < 53)
            {
                productManager.Create(new Product()
                {
                    Name = "Sátras ernyő",
                    Category = "Kiegészítők",
                    Price = 98650,
                    ProductId = 23001
                });
                productManager.Create(new Product()
                {
                    Name = "Haltartó szák",
                    Category = "Kiegészítő",
                    Price = 5500,
                    ProductId = 23002
                });
                productManager.Create(new Product()
                {
                    Name = "Kapaszkodó bilincs",
                    Category = "Kiegészítő",
                    Price = 1543,
                    ProductId = 23003
                });
            }

            //list products
            Console.WriteLine("Products:");
            var products = productManager.GetAll();
            products.ToList().ForEach(Console.WriteLine);
            Console.WriteLine();

            
            if (context.Orders.Count() < 43)
            {
                //ide hozd létre az új rendeléseket felvivő részt
                
            }

            //list orders
            Console.WriteLine("Orders:");
            var orders = orderManager.GetAll();
            orders.ToList().ForEach(Console.WriteLine);
            Console.WriteLine();

            //itt hívd meg azt a függvényt, amely visszaadja, hogy melyik nap hány rendelés történt és az eredményét írasd ki a konzolra


            try
            {
                //itt demonstráld a blacklist-es feladatot
                
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            //itt demonstráld azt a feladatot, amely visszaadja, hogy adott termékeket eddig milyen megrendelők rendelték


            //itt hívd meg A TotalOrderst kiszámoló függvényt


            //itt írasd ki újra a megrendelőket, hogy már benne van a megrendelések össz száma is
            Console.WriteLine("Customers:");

            Console.WriteLine();
            
            //itt hívd meg a rendelések statisztikáját városonként adatbázisba beszúró függvényt

        }
    }
}