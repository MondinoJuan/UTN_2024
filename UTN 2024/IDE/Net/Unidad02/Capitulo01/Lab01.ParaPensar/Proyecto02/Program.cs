using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto02
{
    internal class Program
    {
        static void Main()
        {
            int year;

            Console.WriteLine("Ingrese el año que desea evaluar: ");
            year = Console.Read();

            if ((year % 4) == 0)
            {
                if ((year % 100) == 0)
                {
                    if ((year % 400) == 0)
                    {
                        Console.WriteLine("\nEs biciesto.");
                    }
                    else
                    {
                        Console.WriteLine("\nNo es biciesto.");
                    }
                }
                else
                {
                    Console.WriteLine("\nEs biciesto.");
                }
            }
            else
            {
                Console.WriteLine("\nNo es biciesto.");
            }
        }
    }
}
