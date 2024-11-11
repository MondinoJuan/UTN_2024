using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Jaca.Entidades
{
    public class TipoPropiedad
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string Descripcion { get; set; }


        public TipoPropiedad(string descripcion)
        {
            Descripcion = descripcion;
        }

        public TipoPropiedad() { }
    }
}
