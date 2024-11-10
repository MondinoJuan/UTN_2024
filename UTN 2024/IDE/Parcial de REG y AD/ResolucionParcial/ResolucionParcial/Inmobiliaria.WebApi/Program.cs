using Inmobiliaria.Domain;

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
    app.UseHttpLogging();
}

app.UseHttpsRedirection();


#region Propiedades

app.MapGet("/propiedades/{id}", (int id) =>
{
    PropiedadService propiedadService = new PropiedadService();

    return propiedadService.Get(id);
})
.WithName("GetPropiedad")
.WithOpenApi();

app.MapGet("/propiedades", () =>
{
    PropiedadService propiedadService = new PropiedadService();

    return propiedadService.GetAll();
})
.WithName("GetAllPropiedades")
.WithOpenApi();

app.MapPost("/propiedades", (Propiedad propiedad) =>
{
    PropiedadService propiedadService = new PropiedadService();

    propiedadService.Add(propiedad);
})
.WithName("AddPropiedad")
.WithOpenApi();

app.MapPut("/propiedades", (Propiedad propiedad) =>
{
    PropiedadService propiedadService = new PropiedadService();

    propiedadService.Update(propiedad);
})
.WithName("UpdatePropiedad")
.WithOpenApi();

app.MapDelete("/propiedades/{id}", (int id) =>
{
    PropiedadService propiedadService = new PropiedadService();

    propiedadService.Delete(id);
})
.WithName("DeletePropiedad")
.WithOpenApi();

#endregion 

#region TipoPropiedades

app.MapGet("/tipos-propiedades", () =>
{
    TipoPropiedadService tipoPropiedadService = new TipoPropiedadService();

    return tipoPropiedadService.GetAll();
})
.WithName("GetAllTiposPropiedades")
.WithOpenApi();
#endregion 

app.Run();
