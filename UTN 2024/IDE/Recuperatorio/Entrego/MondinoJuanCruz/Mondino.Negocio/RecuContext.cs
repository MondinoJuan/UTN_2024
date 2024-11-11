using Microsoft.EntityFrameworkCore;

namespace Mondino.Negocio
{
    public class RecuContext : DbContext
    {
        public RecuContext()
        {
            this.Database.EnsureCreated();
        }

        public DbSet<Producto> Productos { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer
                (@"Data Source=DESKTOP-6HBL1R6\SQLEXPRESS;Initial Catalog=MondinoRecu;Integrated Security=True;Encrypt=False");
        }
    }
}
