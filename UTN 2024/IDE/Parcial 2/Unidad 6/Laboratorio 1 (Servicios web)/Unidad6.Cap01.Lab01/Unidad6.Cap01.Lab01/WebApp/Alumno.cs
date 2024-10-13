using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApp
{
    public class Alumno
    {
        [Key]
        public int AlumnoId { get; set; }

        [Required]
        [StringLength(50)]
        public string Apellido { get; set; }

        [Required]
        [StringLength(50)]
        public string Nombre { get; set; }

        [Required]
        public int Legajo { get; set; }

        [StringLength(255)]
        public string Direccion { get; set; }
    }
}
