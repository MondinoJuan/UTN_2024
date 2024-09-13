using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto04
{
    internal class Program
    {
        static void Main()
        {
            int min, max;

            min = 0;
            max = 100;

            Console.WriteLine("Los numeros pares entre el 1 y el 100 son: ");

            while (min < (max - 2))
            {
                min += 2;
                Console.WriteLine(min);
            }
        }
    }
}
