using Microsoft.EntityFrameworkCore;
using System;

namespace NagyZHPractice;

public class Program
{
    public static void Main()
    {
        Console.WriteLine("Hello World");
        ListAllOwnersWithCarsAndRepairs();
    }

    public static void ListAllOwnersWithCarsAndRepairs()
    {
        using (CarsContext context = new CarsContext())
        {
            foreach (Owner owner in context.Owners.Include(o => o.Cars).ThenInclude(c => c.Repairs))
            {
                Console.WriteLine($"{owner.Id} {owner.Name} ({owner.Address ?? "Unknown address"})");

                foreach (Car car in owner.Cars)
                {
                    Console.WriteLine($" {car.Id} {car.Type}, {car.PlateNumber}");

                    foreach (Repair repair in car.Repairs.OrderBy(r => r.Date))
                    {
                        Console.WriteLine($"  at {repair.Date}: {repair.Description}");
                    }
                }
            }
        }
    }

    public void AddCar(string type, string plate, int ownerId)
    {
        using (CarsContext context = new CarsContext())
        {
            context.Owners.Find(ownerId)?.Cars.Add(new Car
            {
                Type = type,
                PlateNumber = plate
            });
            context.SaveChanges();
        }
    }

    public void DeleteCarOfPlate(string plate)
    {
        try
        {
            using (CarsContext context = new CarsContext())
            {
                Car toDelete = context.Cars.First(c => c.PlateNumber == plate);
                context.Cars.Remove(toDelete);
                context.SaveChanges();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("No car found");
        }
    }

    public void DeleteCarOfPlateWhere(string plate)
    {
        using (CarsContext context = new CarsContext())
        {
            context.Cars.Where(c => c.PlateNumber == plate).ExecuteDelete();
        }
    }

    public void ChangePlateNumber(int carId, string plate)
    {
        using (CarsContext context = new CarsContext())
        {
            Car car = context.Cars.Find(carId);
            if (car != null)
            {
                car.PlateNumber = plate;
            }
            context.SaveChanges();
        }
    }

    public void ChangePlateNumberWhere(int carId, string plate)
    {
        using (CarsContext context = new CarsContext())
        {
            Car? result = context.Cars
                .Where(c => c.Type == "Lada")
                .Include(c => c.Repairs)
                .Include(c => c.Owner)
                .ToList()
                .MaxBy(c => c.Repairs.Count);

            if (result == null) { Console.WriteLine("No such car"); }
            else
            {
                Console.WriteLine($"Owner: {result.Owner?.Name ?? "Unknown"}");
            }
        }
    }

    public void Complex(int carId, string plate)
    {
        using (CarsContext context = new CarsContext())
        {
            var selected = context.Owners
                .Include(o => o.Cars)
                .ThenInclude(c => c.Repairs)
                .Where(o => o.Cars
                    .Any(c => c.Repairs
                        .Any(r => r.Date >= new DateOnly(2024, 8, 1))))
                .OrderBy(o => o.Name);

            foreach (Owner owner in selected)
            {
                Console.WriteLine(owner.Name);
            }
        }
    }
}


    
