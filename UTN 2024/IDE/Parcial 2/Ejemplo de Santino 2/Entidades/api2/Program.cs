
namespace api2
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

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
                app.UseHttpLogging(); // agregar este
            }


            app.UseHttpsRedirection();

            app.MapPut("/alumno", (Alumno alumno) =>
            {
                AlumnoService alumnoService = new AlumnoService();
                alumnoService.Add(alumno);

            });

            app.MapGet("/alumno/{id}", (string id) =>
            {
                return Results.Ok(service.GetAll());
            });


            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
