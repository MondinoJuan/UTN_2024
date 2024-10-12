
using Microsoft.EntityFrameworkCore;
using Cataldi.Entidades;
namespace Datos
{
    internal class AlumnoContext : DbContext
    {
        internal DbSet<Alumno> Alumnos { get; set; }
        internal AlumnoContext()
        {
            this.Database.EnsureCreated(); // Crea la base de datos si no existe
            // Se podria eliminar la linea de arriba y ejecutar esto en consola. (seria el migrations)
            // Add-Migration InitialCreate
            // Update-Database
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) =>
         optionsBuilder.UseSqlServer(@"Server=(localdb)\MSSQLLocalDB;Initial Catalog=AlumnoDb");
    }
}
