using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto01
{
    internal class Program
    {
        static void Main()
        {
            float num1, num2, resultado;

            Console.WriteLine("Ingrese el primer valor: ");
            num1 = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ingrese el segundo valor: ");
            num2 = Convert.ToInt32(Console.ReadLine());

            resultado = num1 + num2;

            Console.WriteLine("\nEl resultado de la suma de " + num1 + " y " + num2 + " es " + resultado);
        }
    }
}
