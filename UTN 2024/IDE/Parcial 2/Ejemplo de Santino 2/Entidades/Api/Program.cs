using Datos;
using Cataldi.Entidades;
namespace Api
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
                app.UseHttpLogging(); // agregar este
            }
            
           
            app.UseHttpsRedirection();

            //metodo get
            app.MapGet("/alumnos", () =>
            {
                var service = new AlumnoService();
                return service.GetAll();
            })
            .WithName("GetAlumnos");

            app.MapControllers();

            app.Run();
        }
    }
}
