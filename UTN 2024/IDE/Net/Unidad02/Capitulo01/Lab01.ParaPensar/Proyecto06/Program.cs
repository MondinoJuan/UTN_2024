using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto06
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num = 0, cent, noventa, cincuenta, cuarenta, dec, nueve, cinco, cuatro, uni;
            string resultado = "";

            Console.WriteLine("Ingrese el numero entero que quiere transformar a romano (0 < num < 400): ");
            num = Convert.ToInt32(Console.ReadLine());


            if (num > 0 && num < 400)
            {
                if (num % 100 >= 0)
                {
                    cent = num / 100;
                    string sCent = "C";

                    for (int i = 0; i < cent; i++)
                    {
                        resultado += sCent;
                        num -= 100;
                    }
                }

                if (num % 90 >= 0)
                {
                    noventa = num / 90;
                    string sNoventa = "XC";

                    for (int i = 0; i < noventa; i++)
                    {
                        resultado += sNoventa;
                        num -= 90;
                    }
                }

                if (num % 50 >= 0)
                {
                    cincuenta = num / 50;
                    string sCincuenta = "L";

                    for (int i = 0; i < cincuenta; i++)
                    {
                        resultado += sCincuenta;
                        num -= 50;
                    }
                }

                if (num % 40 >= 0)
                {
                    cuarenta = num / 40;
                    string sCuarenta = "XL";

                    for (int i = 0; i < cuarenta; i++)
                    {
                        resultado += sCuarenta;
                        num -= 40;
                    }
                }

                if (num % 10 >= 0)
                {
                    dec = num / 10;
                    string sDec = "X";

                    for (int i = 0; i < dec; i++)
                    {
                        resultado += sDec;
                        num -= 10;
                    }
                }

                if (num % 9 >= 0)
                {
                    nueve = num / 9;
                    string sNueve = "IX";

                    for (int i = 0; i < nueve; i++)
                    {
                        resultado += sNueve;
                        num -= 9;
                    }
                }

                if (num % 5 >= 0)
                {
                    cinco = num / 5;
                    string sCinco = "V";

                    for (int i = 0; i < cinco; i++)
                    {
                        resultado += sCinco;
                        num -= 5;
                    }
                }

                if (num % 4 >= 0)
                {
                    cuatro = num / 4;
                    string sCuatro = "IV";

                    for (int i = 0; i < cuatro; i++)
                    {
                        resultado += sCuatro;
                        num -= 4;
                    }
                }

                if (num != 0)
                {
                    uni = num;
                    string sUni = "I";

                    for (int i = 0; i < uni; i++)
                    {
                        resultado += sUni;
                        num -= 1;
                    }
                }

                Console.WriteLine("\n\nEl numero romano es: ");
                Console.WriteLine(resultado);

            }
            else
            {
                Console.WriteLine("\n\nEl numero ingresado esta fuera del rango establecido.");
            }
        }
    }
}
