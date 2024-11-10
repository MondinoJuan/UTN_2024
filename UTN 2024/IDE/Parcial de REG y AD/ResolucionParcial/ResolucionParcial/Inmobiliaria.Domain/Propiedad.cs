namespace Inmobiliaria.Domain
{
    public class Propiedad
    {
        public int Id { get; set; }
        public int TipoPropiedadId { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public int M2 { get; set; }
        public int CantidadHabitaciones { get; set; }
        public DateTime FechaAlta { get; set; }

        public TipoPropiedad TipoPropiedad { get; set; }

        public Propiedad()
        {
            // En el caso de modificación se va pisa manteniendo su valor original en la base de datos.
            this.FechaAlta = DateTime.Now;
        }
    }
}
