using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.EntityFrameworkCore;
using System;

namespace WebApp
{
    public class UniversidadDbContext : DbContext
    {
        public UniversidadDbContext(DbContextOptions<UniversidadDbContext> options) : base(options)
        {
            this.Database.EnsureCreated();
        }

        public DbSet<Alumno> Alumnos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Alumno>().ToTable("Alumnos");

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("Server = localhost; Database = netDB; User = root; Password = 0717; Pooling = true",
                new MySqlServerVersion(new Version(8, 0, 39)));

                optionsBuilder.LogTo(Console.WriteLine, LogLevel.Information);

            }
        }
    }
}
