using Microsoft.EntityFrameworkCore;
using WebApp;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddDbContext<UniversidadDbContext>();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        var app = builder.Build();

        app.UseSwagger();
        app.UseSwaggerUI();


        app.MapGet("/", () => "Hello World!");


        app.MapGet("/alumnos", async (UniversidadDbContext context) =>
        {
            List<Alumno> alumnos = await context.Alumnos.ToListAsync();

            return Results.Ok(alumnos);
        }
        );
                


        app.MapGet("/alumnos/{id}", async (int id, UniversidadDbContext context) =>
            await context.Alumnos.FindAsync(id) is Alumno alumno
                ? Results.Ok(alumno)
                : Results.NotFound());


        app.MapPost("/alumnos", async (Alumno alumno, UniversidadDbContext context) =>
        {
            context.Alumnos.Add(alumno);
            await context.SaveChangesAsync();

            return Results.Created($"/alumnos/{alumno.AlumnoId}", alumno);
        });

        app.MapDelete("/alumnos/{id}", async (int id, UniversidadDbContext context) => {
            var alumno = await context.Alumnos.FindAsync(id);
                
            if(alumno != null) {
                context.Alumnos.Remove(alumno);
                await context.SaveChangesAsync();
                Results.NoContent();
            }
            else
            {
                Results.NotFound(new { message = "Alumno not found" });
            }

        }
        );
        app.MapPut("/alumnos/{id}", async(int id, Alumno updatedAlumno, UniversidadDbContext context) => {
            var existingAlumno = await context.Alumnos.FindAsync(id);

            if (existingAlumno != null)
            {
                existingAlumno.Apellido = updatedAlumno.Apellido;
                existingAlumno.Nombre = updatedAlumno.Nombre;
                existingAlumno.Legajo = updatedAlumno.Legajo;
                existingAlumno.Direccion = updatedAlumno.Direccion;
                
                context.Alumnos.Update(existingAlumno);
                await context.SaveChangesAsync();
                return Results.NoContent();

            }
            else
            {
                return Results.NotFound(new { message = "Alumno not found" });
            }

        }
        );

        

        app.Run();
    }
}