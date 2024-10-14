using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Entidades;

namespace Datos
{
    class PracticaContext : DbContext
    {
        internal DbSet<Alumno2> Alumnos { get; set; }

        internal PracticaContext()
        {
            this.Database.EnsureCreated(); // para q se cree si no esta
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) =>
            optionsBuilder.UseSqlServer(@"Server=(localdb)\MSSQLLocalDB;Initial Catalog=PracticaDb");

    }
}
