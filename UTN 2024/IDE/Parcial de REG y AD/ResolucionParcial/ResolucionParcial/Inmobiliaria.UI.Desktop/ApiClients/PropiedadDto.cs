namespace Inmobiliaria.UI.Desktop.ApiCliients
{
    public class PropiedadDto
    {
        public int Id { get; set; }
        public int TipoPropiedadId { get; set; }

        public string TipoPropiedadDescripcion { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public int M2 { get; set; }
        public int CantidadHabitaciones { get; set; }
        public DateTime FechaAlta { get; set; }
    }
}