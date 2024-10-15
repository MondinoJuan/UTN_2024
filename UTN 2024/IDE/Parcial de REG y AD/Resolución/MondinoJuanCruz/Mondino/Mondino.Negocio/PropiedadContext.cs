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
            optionsBuilder.UseSqlServer("Data Source=DESKTOP-6HBL1R6\\SQLEXPRESS;Initial Catalog=Mondino;Integrated Security=True;Encrypt=False;");

    }
}
