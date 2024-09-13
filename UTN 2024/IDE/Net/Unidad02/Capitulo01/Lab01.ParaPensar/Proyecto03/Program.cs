using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto03
{
    internal class Program
    {
        static void Main()
        {
            int num1, num2, cantTotal;

            num1 = 0;
            num2 = 1;

            Console.WriteLine("Ingrese la cantidad de iteraciones de la serie de Fibonacci que quiere observar: (sin contar los dos valores iniciales)");
            cantTotal = int.Parse(Console.ReadLine());

            int[] resultados = new int[cantTotal];

            Console.WriteLine("\n\nLa sumatoria de Fibonacci es la siguiente: \n\t" + num1 + "\n\t" + num2);

            for (int i = 0; i < cantTotal; i++)
            {
                resultados[i] = num1 + num2;

                num1 = num2;
                num2 = resultados[i];

                Console.WriteLine("\t" + resultados[i]);
            }
        }
    }
}
