namespace Jaca.Entidades
{
    public class TipoPropiedadDTO
    {
        public string Descripcion { get; set; }

        public TipoPropiedadDTO(string descripcion)
        {
            Descripcion = descripcion;
        }

        public TipoPropiedadDTO() { }
    }
}
