using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto07
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int cantNum, divisible = 0, numPrim, numPrimGem, divisibleGem = 0, cantImpresos = 0;

            Console.WriteLine("Ingrese la cantidad de numeros primos gemelos que desea observar: ");
            cantNum = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("\n\n");

            while (cantImpresos != cantNum)
            {
                for (int i = 0; cantImpresos != cantNum; i++)
                {
                    divisible = 0;
                    divisibleGem = 0;

                    for (int j = 2; j < i; j++)
                    {
                        if (i % j == 0)
                        {
                            divisible++;
                        }
                    }

                    if (divisible == 0)
                    {
                        numPrim = i;
                        numPrimGem = numPrim + 2;

                        for (int j = 2; j < numPrimGem; j++)
                        {
                            if (numPrimGem % j == 0)
                            {
                                divisibleGem++;
                            }
                        }

                        if (divisibleGem == 0)
                        {
                            Console.WriteLine((cantImpresos + 1) + "-" + "\t" + numPrim + "\t" + numPrimGem);
                            cantImpresos++;
                        }
                    }
                }
            }
        }
    }
}
