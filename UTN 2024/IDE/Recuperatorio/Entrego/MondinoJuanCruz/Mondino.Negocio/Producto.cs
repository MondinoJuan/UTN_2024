using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Mondino.Negocio
{
    public class Producto
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id {  get; set; }

        public string Codigo { get; set; }

        public string Descripcion { get; set; }

        public decimal Precio { get; set; }
    }
}
