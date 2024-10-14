
using System.Transactions;
using Datos;

namespace PruebaApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddHttpLogging(o => { }); // agregar este


            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
                app.UseHttpLogging(); // agregado
            }

            //Metodos
            app.MapGet("/alumnos", () =>
            {
                PracticaService servicio = new PracticaService();
                var alumnos = servicio.GetAll();
                return alumnos;

            }).WithName("alumnos");

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
