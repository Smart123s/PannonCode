using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Construction.Exceptions
{
    public class BlacklistException(string name) : Exception($"{name} is on the blacklist");
}
