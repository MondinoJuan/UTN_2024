using System;
using Pomelo.EntityFrameworkCore.MySql;
using Microsoft.EntityFrameworkCore;

public class UniversidadContext : DbContext
{
    public UniversidadContext()
    {
        this.Database.EnsureCreated();
    }

    public DbSet<Alumno> Alumnos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseMySql("Server=localhost;Database=Universidad;User=root;Password=0717;",
            ServerVersion.AutoDetect("Server=localhost;Database=Universidad;User=root;Password=0717;"));
    }
}


/*
 * CON SQL SERVER *
using Microsoft.EntityFrameworkCore.SqlServer;
public class UniversidadContext : DbContext
{
    public UniversidadContext()
    {
        this.Database.EnsureCreated();
    }

    public DbSet<Alumno> Alumnos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(@"Server=(localdb)\MSSQLLocalDB;Initial
                                    Catalog=Universidad;Integrated Security=true");
    }
}
*/