using Microsoft.EntityFrameworkCore;
using LabAPIRNC_U6.Models;

namespace LabAPIRNC_U6.Context
{
    public class MyDbContext : DbContext
    {
        public MyDbContext()
        {
           this.Database.EnsureCreated();
        }
        public MyDbContext(DbContextOptions<MyDbContext> options) : base(options) { }
        public DbSet<Alumno> Alumnos { get; set; }
    }
}
