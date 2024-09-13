using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Desicion
{
    internal class Program
    {
        static void Main()
        {
            ConsoleKeyInfo opcion;
            string inputTexto;
            inputTexto = Console.ReadLine();

            if (!string.IsNullOrWhiteSpace(inputTexto))
            {
                Console.WriteLine("Se ingreso el siguiente texto: " + inputTexto);

                do
                {

                    Console.WriteLine("\n\nMENU DE OPCIONES \n " +
                        "1- Volver el texto a mayusculas." +
                        "\n 2- Volver el texto a minusculas." +
                        "\n 3- Calcular la longitud del string." +
                        "\n 0- Salir.");

                    opcion = Console.ReadKey();                    

                    while (opcion.Key != ConsoleKey.D0 && opcion.Key != ConsoleKey.D1 && opcion.Key != ConsoleKey.D2 && opcion.Key != ConsoleKey.D3)
                    {
                        opcion = Console.ReadKey();
                    }

                    Console.Clear();                  

                    switch (opcion.Key)
                    {
                        case ConsoleKey.D1:
                            Console.WriteLine("\nEl texto queda: " + inputTexto.ToUpper());
                            break;
                        case ConsoleKey.D2:
                            Console.WriteLine("\nEl texto queda: " + inputTexto.ToLower());
                            break;
                        case ConsoleKey.D3:
                            int longi = inputTexto.Length;
                            Console.WriteLine("\nLa cantidad de caracteres es: " + longi);
                            break;
                    }
                } while (opcion.Key != ConsoleKey.D0);
            }
            else
            {
                Console.WriteLine("No se ingreso ingreso texto.");
            }
        }
    }
}