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

                    Console.Clear();

                    if (opcion.Key == ConsoleKey.D1)
                    {
                        Console.WriteLine("\nEl texto queda: " + inputTexto.ToUpper());
                    }
                    else if (opcion.Key == ConsoleKey.D2)
                    {
                        Console.WriteLine("\nEl texto queda: " + inputTexto.ToLower());
                    }
                    else if (opcion.Key == ConsoleKey.D3) { 
                        int longi = inputTexto.Length;
                        Console.WriteLine("\nLa cantidad de caracteres es: " + longi);
                    }
                    else
                    {
                        Console.WriteLine("No se ha elegido una opcion del menu. ");
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


