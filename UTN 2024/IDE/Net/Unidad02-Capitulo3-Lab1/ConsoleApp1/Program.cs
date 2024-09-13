using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;



class Ciudad
{
    public string Nombre { get; set; }
    public string CodigoPostal { get; set; }

    public Ciudad(string nombre, string codigoPostal)
    {
        Nombre = nombre;
        CodigoPostal = codigoPostal;
    }
}

class Empleado
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public decimal Sueldo { get; set; }

    public Empleado(int id, string nombre, decimal sueldo)
    {
        Id = id;
        Nombre = nombre;
        Sueldo = sueldo;
    }
}



internal class Program
{
    private static void Main(string[] args)
    {


        //EJ1, DESCOMENTAR PARA EJECUTAR

        //string[] provinciasArgentinas = {
        //    "Buenos Aires",
        //    "Catamarca",
        //    "Chaco",
        //    "Chubut",
        //    "Córdoba",
        //    "Corrientes",
        //    "Entre Ríos",
        //    "Formosa",
        //    "Jujuy",
        //    "La Pampa",
        //    "La Rioja",
        //    "Mendoza",
        //    "Misiones",
        //    "Neuquén",
        //    "Río Negro",
        //    "Salta",
        //    "San Juan",
        //    "San Luis",
        //    "Santa Cruz",
        //    "Santa Fe",
        //    "Santiago del Estero",
        //    "Tierra del Fuego",
        //    "Tucumán"
        //};


        //var provinciasSelecionadas = provinciasArgentinas.Where(p => p.StartsWith("S") || p.StartsWith("T"));

        //foreach (var province in provinciasSelecionadas)
        //{
        //    Console.WriteLine(province);
        //}
























        //EJ2, DESCOMENTAR PARA EJECUTAR



        //Console.WriteLine("ingrese una serie de numeros separados por espacios:");
        //List<int> numbers = Console.ReadLine()
        //                           .Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)
        //                           .Select(int.Parse)
        //                           .ToList();


        //var numMayoresA20 = numbers.Where(num => num > 20);


        //Console.WriteLine("numeros mayores a 20:");
        //foreach (var num in numMayoresA20)
        //{
        //    Console.WriteLine(num);
        //}




















        //EJ3, DESCOMENTAR PARA EJECUTAR


        //// Crear un ArrayList que incluya al menos 10 ciudades de Argentina con nombre y código postal
        //ArrayList ciudades = new ArrayList()
        //{
        //    new Ciudad("Rosario", "2000"),
        //    new Ciudad("Córdoba", "5000"),
        //    new Ciudad("Buenos Aires", "1000"),
        //    new Ciudad("Mendoza", "5500"),
        //    new Ciudad("San Nicolás de los Arroyos", "2900"),
        //    new Ciudad("Mar del Plata", "7600"),
        //    new Ciudad("La Plata", "1900"),
        //    new Ciudad("Salta", "4400"),
        //    new Ciudad("San Miguel de Tucumán", "4000"),
        //    new Ciudad("Santa Fe", "3000"),
        //    new Ciudad("San Juan", "5400")
        //};

        //// Solicitar al usuario la expresión de búsqueda
        //Console.WriteLine("Ingrese una expresión de búsqueda de tres caracteres:");
        //string expresionBusqueda = Console.ReadLine().ToLower();

        //// Usar LINQ para encontrar las ciudades que coincidan con la expresión de búsqueda
        //var ciudadesCoincidentes = ciudades.OfType<Ciudad>()
        //                                    .Where(ciudad => ciudad.Nombre.ToLower().Contains(expresionBusqueda));

        //// Mostrar los códigos postales de las ciudades coincidentes por consola
        //Console.WriteLine($"Códigos postales de las ciudades que incluyen '{expresionBusqueda}':");
        //foreach (var ciudad in ciudadesCoincidentes)
        //{
        //    Console.WriteLine($"{ciudad.Nombre}: {ciudad.CodigoPostal}");
        //}












        //EJ3, DESCOMENTAR PARA EJECUTAR



        //// Crear una lista de empleados
        //List<Empleado> empleados = new List<Empleado>();

        //// Solicitar al usuario que ingrese datos de empleados hasta que decida salir
        //bool continuar = true;
        //while (continuar)
        //{
        //    Console.WriteLine("Ingrese los datos del empleado:");
        //    Console.Write("ID: ");
        //    int id = Convert.ToInt32(Console.ReadLine());
        //    Console.Write("Nombre: ");
        //    string nombre = Console.ReadLine();
        //    Console.Write("Sueldo: ");
        //    decimal sueldo = Convert.ToDecimal(Console.ReadLine());

        //    empleados.Add(new Empleado(id, nombre, sueldo));

        //    Console.WriteLine("¿Desea ingresar otro empleado? (S/N)");
        //    continuar = Console.ReadLine().Equals("S", StringComparison.OrdinalIgnoreCase);
        //}

        //// Mostrar la lista de empleados ordenada por sueldo de manera ascendente
        //Console.WriteLine("\nEmpleados ordenados por sueldo (ascendente):");
        //var empleadosAscendente = empleados.OrderBy(emp => emp.Sueldo);
        //MostrarEmpleados(empleadosAscendente);

        //// Mostrar la lista de empleados ordenada por sueldo de manera descendente
        //Console.WriteLine("\nEmpleados ordenados por sueldo (descendente):");
        //var empleadosDescendente = empleados.OrderByDescending(emp => emp.Sueldo);
        //MostrarEmpleados(empleadosDescendente);
    
    
    }

    static void MostrarEmpleados(IEnumerable<Empleado> empleados)
    {
        foreach (var empleado in empleados)
        {
            Console.WriteLine($"ID: {empleado.Id}, Nombre: {empleado.Nombre}, Sueldo: {empleado.Sueldo}");
        }
    }



}
