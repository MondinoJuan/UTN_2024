using System;
using System.Linq;
using Pomelo.EntityFrameworkCore.MySql;
using Microsoft.EntityFrameworkCore;
public class Program
{
    public static void Main(string[] args)
    { 
        CrearAlumno(1, "Juan Cruz", "Mondino", 12345, "Urquiza 123");

        LeerAlumno(12345);

        ActualizarAlumno(12345);

        LeerAlumno(12345);

        EliminarAlumno(12345);
    }

    public static void CrearAlumno(int id, string nombre, string apellido, int legajo, string direccion)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = new Alumno
            {
                Id = id,
                Nombre = nombre,
                Apellido = apellido,
                Legajo = legajo,
                Direccion = direccion
            };

            context.Alumnos.Add(alumno);
            context.SaveChanges();
            Console.WriteLine($"Alumno creado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                              $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
        }
    }

    public static void LeerAlumno(int legajo)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = context.Alumnos.FirstOrDefault(a => a.Legajo == legajo);
            if (alumno != null)
            {
                Console.WriteLine($"Alumno encontrado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                  $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
            }
            else
            {
                Console.WriteLine("Alumno no encontrado.");
            }
        }
    }

    public static void ActualizarAlumno(int legajo)
    {
        int decision = 9;

        while (decision > 3 || decision < 0)
        {
            Console.WriteLine("\n¿Qué propiedad desea modificar?" +
            "              \n   1- Nombre" +
            "              \n   2- Apellido" +
            "              \n   3- Dirección" +
            "              \n   0- Salir");
            Console.Write("\nIngrese su decisión: ");
            decision = int.Parse(Console.ReadLine());
        }

        if (decision != 0)
        {
            using (var context = new UniversidadContext())
            {
                var alumno = context.Alumnos.FirstOrDefault(a => a.Legajo == legajo);
                if (alumno != null)
                {
                    switch (decision)
                    {
                        case 1:
                            Console.Write("\nIngrese el nuevo nombre: ");
                            alumno.Nombre = Console.ReadLine();
                            break;

                        case 2:
                            Console.Write("\nIngrese el nuevo apellido: ");
                            alumno.Apellido = Console.ReadLine();
                            break;

                        case 3:
                            Console.Write("\nIngrese la nueva dirección: ");
                            alumno.Direccion = Console.ReadLine();
                            break;
                    }
                    context.SaveChanges();
                    Console.WriteLine($"Alumno actualizado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                      $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
                }
                else
                {
                    Console.WriteLine("Alumno no encontrado.");
                }
            }
        }
    }

    public static void EliminarAlumno(int legajo)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = context.Alumnos.FirstOrDefault(a => a.Legajo == legajo);
            if (alumno != null)
            {
                context.Alumnos.Remove(alumno);
                context.SaveChanges();
                Console.WriteLine($"Alumno eliminado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                  $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
            }
            else
            {
                Console.WriteLine("Alumno no encontrado.");
            }
        }
    }
}

/*
 * CON SQL SERVER *
using using Microsoft.EntityFrameworkCore.SqlServer;
public class Program
{
    public static void Main(string[] args)
    {
     
    }

    public static void CrearAlumno(int id, string nombre, string apellido, int legajo, string direccion)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = new Alumno
            {
                Id = id,
                Nombre = nombre,
                Apellido = apellido,
                Legajo = legajo,
                Direccion = direccion
            };

            context.Alumnos.Add(alumno);
            context.SaveChanges();
            Console.WriteLine($"Alumno creado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                              $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
        }
    }

    public static void LeerAlumno(int legajo)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = context.Alumnos.FirstOrDefault(a => a.Legajo == legajo);
            if (alumno != null)
            {
                Console.WriteLine($"Alumno creado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                  $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
            }
            else
            {
                Console.WriteLine("Alumno no encontrado.");
            }
        }
    }

    public static void ActualizarAlumno(int legajo)
    {
        int decision = 9;

        while (decision > 3 || decision < 0)
        {
            Console.WriteLine("\n¿Qué propiedad desea modificar?" +
            "              \n   1- Nombre" +
            "              \n   2- Apellido" +
            "              \n   3- Direccion" +
            "              \n   0- Salir");
            Console.Write("\nIngrese su decisión: ");
            decision = int.Parse(Console.ReadLine());
        }

        if (decision != 0)
        {
            using (var context = new UniversidadContext())
            {
                var alumno = context.Alumnos.Find(legajo);
                if (alumno != null)
                {
                    switch (decision)
                    {
                        case 1:
                            string nuevoNombre;
                            Console.Write("\nIngrese el nuevo nombre: ");
                            nuevoNombre = Console.ReadLine();
                            alumno.Nombre = nuevoNombre;
                            break;

                        case 2:
                            string nuevoApellido;
                            Console.Write("\nIngrese el nuevo apellido: ");
                            nuevoApellido = Console.ReadLine();
                            alumno.Apellido = nuevoApellido;
                            break;

                        case 3:
                            string nuevaDireccion;
                            Console.Write("\nIngrese la nueva direccion: ");
                            nuevaDireccion = Console.ReadLine();
                            alumno.Apellido = nuevaDireccion;
                            break;
                    }
                    context.SaveChanges();
                    Console.WriteLine($"Alumno creado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                      $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
                }
                else
                {
                    Console.WriteLine("Alumno no encontrado.");
                }
            }
        }
    }

    public static void EliminarAlumno(int legajo)
    {
        using (var context = new UniversidadContext())
        {
            var alumno = context.Alumnos.Find(legajo);
            if (alumno != null)
            {
                context.Alumnos.Remove(alumno);
                context.SaveChanges();
                Console.WriteLine($"Alumno creado: ID: {alumno.Id}, Nombre: {alumno.Nombre}, Apellido: {alumno.Apellido}, " +
                                  $"Legajo: {alumno.Legajo}, Dirección: {alumno.Direccion}");
            }
            else
            {
                Console.WriteLine("Alumno no encontrado.");
            }
        }
    }
}
*/