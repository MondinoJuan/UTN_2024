namespace Inmobiliaria.Domain
{
    public class TipoPropiedadService
    {
        public IEnumerable<TipoPropiedad> GetAll()
        {
            using var context = new InmobiliariaContext();
            return context.TiposPropiedades.ToList();
        }
    }
}
