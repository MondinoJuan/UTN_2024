using Microsoft.EntityFrameworkCore;

namespace Mondino.Negocio
{
    public class PropiedadContext : DbContext
    {
        public DbSet<Propiedad> Propiedades { get; set; }

        public PropiedadContext()
        {
            Database.EnsureCreated();
        }
        public PropiedadContext(DbContextOptions<PropiedadContext> options) : base(options) { }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) =>
            optionsBuilder.UseSqlServer(@"Server=localhost\SQLEXPRESS;Database=Mondino;Trusted_Connection=True;");

    }
}
