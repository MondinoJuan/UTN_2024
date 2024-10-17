using Microsoft.EntityFrameworkCore;
using Mondino.Negocio;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddDbContext<PropiedadContext>(options => options.UseSqlServer("Data Source=DESKTOP-KD3CGEG\\SQLEXPRESS;Initial Catalog=Mondino;Integrated Security=True;Encrypt=False;"));

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();
