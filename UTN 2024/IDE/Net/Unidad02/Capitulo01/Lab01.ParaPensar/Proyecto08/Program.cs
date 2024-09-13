using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto08
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int intentos = 0;
            string clave = " ", claveDefault = "1234";

            while (intentos < 4 && clave != claveDefault)
            {
                intentos++;

                Console.WriteLine("Introduzca la clave (es 1234): ");
                clave = Console.ReadLine();

                if (clave == claveDefault)
                {
                    Console.WriteLine("\nLA CLAVE ES CORRECTA!!");
                }else
                {
                    Console.WriteLine("\nLA CLAVE ES INCORRECTA!!");
                }
            }
        }
    }
}
