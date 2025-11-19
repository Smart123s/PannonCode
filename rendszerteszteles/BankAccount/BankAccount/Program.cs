using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BankAccount
{
    class Program
    {
        static void Main(string[] args)
        {
            BankAccount bankAccount = new BankAccount("John", 10000);
            Console.WriteLine($"{bankAccount.CustomerName} - {bankAccount.Balance}");

            bankAccount.Debit(2000);
            Console.WriteLine($"{bankAccount.CustomerName} - {bankAccount.Balance}");

            bankAccount.Credit(5000);
            Console.WriteLine($"{bankAccount.CustomerName} - {bankAccount.Balance}");
        }
    }
}
