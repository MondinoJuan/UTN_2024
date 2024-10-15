namespace Mondino.Negocio
{
    public class PropiedadesServicios
    {
        public IEnumerable<Propiedad>? GetAll()
        {
            using var context = new PropiedadContext();
            try
            {
                var propiedad = context.Propiedades.ToList();
                return propiedad;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                var propiedad = new List<Propiedad>();
                return propiedad;
            }


        }
        public void Update(Propiedad propiedad)
        {
            using var context = new PropiedadContext();
            Propiedad? _aModif = context.Propiedades.Find(propiedad.Id);
            if (_aModif != null)
            {
                context.Propiedades.Update(propiedad);
                context.SaveChanges();
            }
        }

        public Propiedad? Get(long id)
        {
            using var context = new PropiedadContext();
            return context.Propiedades.Find(id);
        }
        public void Delete(long id)
        {
            using var context = new PropiedadContext();
            Propiedad? alumnoToDelete = context.Propiedades.Find(id);
            if (alumnoToDelete != null)
            {
                context.Propiedades.Remove(alumnoToDelete);
                context.SaveChanges();
            }
        }
    }
}
