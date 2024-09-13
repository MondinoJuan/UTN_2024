using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Iteraciones
{
    internal class Program
    {
        static void Main()
        {
            int cantItera = 5;
            string[] arreglo;
            arreglo = new string[cantItera];

            Console.WriteLine("Ingrese los elementos del arreglo:\n");

            for (int i = 0; i < cantItera; i++)
            {
                Console.WriteLine(i + "- ");
                arreglo[i] = Console.ReadLine();
            }

            Console.WriteLine("\n\n");

            for (int i = cantItera - 1; i >= 0; i--)
            {
                Console.WriteLine(i + "- " + arreglo[i]);
            }
        }
    }
}
