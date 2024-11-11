using Microsoft.EntityFrameworkCore;
using Jaca.Datos;

namespace Jaca.Servicios
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", policy =>
                {
                    policy.AllowAnyOrigin()    // Permitir solicitudes desde cualquier origen
                          .AllowAnyHeader()    // Permitir cualquier cabecera
                          .AllowAnyMethod();   // Permitir cualquier método
                });
            });

            builder.Services.AddControllers();

            builder.Services.AddDbContext<InmobiliariaContext>(
                options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"))
            );

            builder.Services.AddSwaggerGen(); 

            builder.Services.AddEndpointsApiExplorer();

            var app = builder.Build();

            app.UseSwagger(); 
            app.UseSwaggerUI();

            app.UseCors("AllowAll");

            app.UseHttpsRedirection();
            app.UseAuthorization();
            app.MapControllers();

            app.Run();
        }
    }
}
