using Domain.Model;
using Microsoft.EntityFrameworkCore;

namespace Domain
{
    internal class ClienteContext : DbContext
    {
        internal DbSet<Cliente> Clientes { get; set; }

        internal ClienteContext()
        {
            this.Database.EnsureCreated();
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) =>
            optionsBuilder.UseSqlServer(@"Server=(localdb)\MSSQLLocalDB;Initial Catalog=ClienteDb");
    }
}
