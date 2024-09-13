using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto05
{
    internal class Program
    {
        enum Meses
        {
            Enero = 1,
            Febrero = 2,
            Marzo = 3,
            Abril = 4,
            Mayo = 5,
            Junio = 6,
            Julio = 7,
            Agosto = 8,
            Septiembre = 9,
            Octubre = 10,
            Noviembre = 11,
            Diciembre = 12
        }
        static void Main()
        {
            string mesIng;

            Console.WriteLine("Ingrese el mes del que quiera saber el numero: ");
            mesIng = Console.ReadLine();
            mesIng = mesIng.ToUpper();

            switch (mesIng)
            {
                case "ENERO":
                    Console.WriteLine(Meses.Enero + " + " + (int)Meses.Enero);
                    break;
                case "FEBRERO":
                    Console.WriteLine(Meses.Febrero + " + " + (int)Meses.Febrero);
                    break;
                case "MARZO":
                    Console.WriteLine(Meses.Marzo + " + " + (int)Meses.Marzo);
                    break;
                case "ABRIL":
                    Console.WriteLine(Meses.Abril + " + " + (int)Meses.Abril);
                    break;
                case "MAYO":
                    Console.WriteLine(Meses.Mayo + " + " + (int)Meses.Mayo);
                    break;
                case "JUNIO":
                    Console.WriteLine(Meses.Junio + " + " + (int)Meses.Junio);
                    break;
                case "JULIO":
                    Console.WriteLine(Meses.Julio + " + " + (int)Meses.Julio);
                    break;
                case "AGOSTO":
                    Console.WriteLine(Meses.Agosto + " + " + (int)Meses.Agosto);
                    break;
                case "SEPTIEMBRE":
                    Console.WriteLine(Meses.Septiembre + " + " + (int)Meses.Septiembre);
                    break;
                case "OCTUBRE":
                    Console.WriteLine(Meses.Octubre + " + " + (int)Meses.Octubre);
                    break;
                case "NOVIEMBRE":
                    Console.WriteLine(Meses.Noviembre + " + " + (int)Meses.Noviembre);
                    break;
                case "DICIEMBRE":
                    Console.WriteLine(Meses.Diciembre + " + " + (int)Meses.Diciembre);
                    break;
            }
        }
    }
}
