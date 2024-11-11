using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Jaca.Entidades
{
    public class Propiedad
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        [ForeignKey("TipoPropiedad")]
        public int IdTipoPropiedad { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "El título no puede tener más de 50 caracteres.")]
        public string Titulo { get; set; }

        [Required(ErrorMessage = "La descripción no puede estar vacía.")]
        [MaxLength(100)]
        public string Descripcion { get; set; }

        [Required(ErrorMessage = "La cantidad de habitaciones debe ser un número entero.")]
        [Range(0, 10, ErrorMessage = "La cantidad de habitaciones debe estar entre 0 y 10.")]
        public int CantidadHabitaciones { get; set; }

        [Required]
        public int M2 { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 2)")]
        public decimal Precio { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime FechaAlta { get; set; }

        [Browsable(false)]
        public TipoPropiedad TipoPropiedad { get; set; }

        public Propiedad(int idTipoPropiedad, string titulo, string descripcion, int cantidadHabitaciones, int m2, decimal precio)
        {
            IdTipoPropiedad = idTipoPropiedad;
            Titulo = titulo;
            Descripcion = descripcion;
            CantidadHabitaciones = cantidadHabitaciones;
            M2 = m2;
            Precio = precio;
            FechaAlta = DateTime.Now;
        }

        public Propiedad() { }
    }
}
