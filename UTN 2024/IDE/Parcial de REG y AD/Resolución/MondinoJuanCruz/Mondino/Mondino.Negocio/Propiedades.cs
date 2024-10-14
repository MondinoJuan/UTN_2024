using System;
using System.ComponentModel.DataAnnotations;

namespace Mondino.Negocio
{
    public class Propiedad
    {
        [Key]
        public int Id { get; set; }
        public int TipoPropiedad { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public int CantidadHabitaciones { get; set; }
        public int M2 { get; set; }
        public decimal Precio { get; set; }
        public DateTime FechaAlta { get; set; } = DateTime.Now;
    }
}
