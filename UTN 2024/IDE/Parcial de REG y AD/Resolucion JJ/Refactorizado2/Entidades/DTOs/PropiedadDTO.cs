namespace Jaca.Entidades
{
    public class PropiedadDTO
    {
        public int IdTipoPropiedad { get; set; }

        public string Titulo { get; set; }

        public string Descripcion { get; set; }

        public int CantidadHabitaciones { get; set; }

        public int M2 { get; set; }

        public decimal Precio { get; set; }

        public DateTime FechaAlta { get; set; }

        public PropiedadDTO(int idTipoPropiedad, string titulo, string descripcion, int cantidadHabitaciones, int m2, decimal precio)
        {
            IdTipoPropiedad = idTipoPropiedad;
            Titulo = titulo;
            Descripcion = descripcion;
            CantidadHabitaciones = cantidadHabitaciones;
            M2 = m2;
            Precio = precio;
            FechaAlta = DateTime.Now;
        }

        public PropiedadDTO() { }
    }
}
