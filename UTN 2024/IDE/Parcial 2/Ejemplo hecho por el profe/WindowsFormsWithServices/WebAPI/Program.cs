using Domain.Services;
using Domain.Model;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHttpLogging(o => { });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    //Falta configurar de manera correcta        
    app.UseHttpLogging();
}

app.UseHttpsRedirection();

//Actualmente estamos usando los objetos del Domain Model, deberiamos usar ViewModels o DTOs         


app.MapGet("/clientes/{id}", (int id) =>
{
    ClienteService clienteService = new ClienteService();

    return clienteService.Get(id);
})
.WithName("GetCliente")
.WithOpenApi();

app.MapGet("/clientes", () =>
{
    ClienteService clienteService = new ClienteService();

    return clienteService.GetAll();
})
.WithName("GetAllClientes")
.WithOpenApi();

app.MapPost("/clientes", (Cliente cliente) =>
{
    ClienteService clienteService = new ClienteService();

    clienteService.Add(cliente);
})
.WithName("AddCliente")
.WithOpenApi();

app.MapPut("/clientes", (Cliente cliente) =>
{
    ClienteService clienteService = new ClienteService();

    clienteService.Update(cliente);
})
.WithName("UpdateCliente")
.WithOpenApi();

app.MapDelete("/clientes/{id}", (int id) =>
{
    ClienteService clienteService = new ClienteService();

    clienteService.Delete(id);
})
.WithName("DeleteCliente")
.WithOpenApi();

app.Run();
