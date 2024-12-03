using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FishingShop
{
    internal class BlackListException : Exception
    {
        public BlackListException(string customerName) :
            base($"The customer {customerName} is blacklisted")
        {
        
        }
    }
}
