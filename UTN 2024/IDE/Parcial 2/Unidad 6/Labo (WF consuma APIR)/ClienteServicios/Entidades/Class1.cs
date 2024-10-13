using System.ComponentModel.DataAnnotations;

namespace Entidades
{
    public class Alumno
    {
        [Key]
        public string DNI { get; set; }
        public string ApellidoNombre { get; set; }
        public string Email { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public decimal NotaPromedio { get; set; }
    }
}
