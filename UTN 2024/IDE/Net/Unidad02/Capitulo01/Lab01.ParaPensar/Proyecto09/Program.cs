using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto09
{
    internal class Program
    {
        static string imprimeEspacios(int fI, int cF, string rta)
        {
            if (fI != cF)
            {
                for (int j = fI; j < (cF - 1); j++)
                {
                    rta += " ";
                }
            }
            return (rta);
        }

        static void Main()
        {
            int cantFilas, filasImpresas = 0;

            Console.WriteLine("Ingrese la cantidad de filas que quiere observar del triangulo: ");
            cantFilas = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("\nEl triangulo de * quedaria: ");

            for (int i = 0; i < cantFilas; i++)
            {
                string respuesta = "";
                respuesta = imprimeEspacios(filasImpresas, cantFilas, respuesta);

                for (int j = 0; j < ((filasImpresas * 2) + 1); j++)
                {
                    respuesta += "*";
                }

                respuesta = imprimeEspacios(filasImpresas, cantFilas, respuesta);

                Console.WriteLine(respuesta);
                filasImpresas++;
            }
        }
    }
}
