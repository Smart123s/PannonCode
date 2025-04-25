using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KisZH1Parctice
{
    internal class TestResult
    {
        public string Group { get; set; }
        public int Score { get; set; }
        public int WorkTime { get; set; }

        public override string ToString()
        {
            return $"Group: {Group}, Score: {Score}, Time: {WorkTime}";
        }
    }
}
