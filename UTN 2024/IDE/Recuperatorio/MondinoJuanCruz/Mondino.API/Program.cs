using Mondino.Negocio;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/productos", () =>
{

    return Servicios.GetAllProductos();
})
.WithName("GetAllProductos");

app.MapPost("/productos", (Producto producto) =>
{
    try
    {
        Servicios.CrearProducto(producto);
        return Results.Ok(new { message = "Producto creado exitosamente" });
    }
    catch (ArgumentException ex)
    {
        return Results.BadRequest(ex.Message);
    }
})
.WithName("CrearProducto");

app.MapPut("/productos", (Producto producto) =>
{
        Servicios.ActualizarProducto(producto);
        return Results.Ok(new { message = "Producto actualizado exitosamente" });
})
.WithName("ActualizarProducto");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
