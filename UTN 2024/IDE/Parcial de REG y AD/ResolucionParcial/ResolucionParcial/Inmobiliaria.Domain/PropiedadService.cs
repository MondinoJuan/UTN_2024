
using Microsoft.EntityFrameworkCore;

namespace Inmobiliaria.Domain
{
    public class PropiedadService
    {
        public void Add(Propiedad propiedad)
        {
            if (PropiedadValidation.IsValid(propiedad))
            {
                using var context = new InmobiliariaContext();

                context.Propiedades.Add(propiedad);
                context.SaveChanges();
            }
        }

        public void Delete(int id)
        {
            using var context = new InmobiliariaContext();

            Propiedad propiedadToDelete = context.Propiedades.Find(id);

            if (propiedadToDelete != null)
            {
                context.Propiedades.Remove(propiedadToDelete);
                context.SaveChanges();
            }
        }

        public Propiedad Get(int id)
        {
            using var context = new InmobiliariaContext();

            return context.Propiedades.Find(id);
        }

        public IEnumerable<PropiedadDto> GetAll()
        {
            using var context = new InmobiliariaContext();
            //Método para regularidad
            //return context.Propiedades.ToList();

            var propiedades = context.Propiedades
                .Include(x => x.TipoPropiedad)
                .Where(b => b.FechaAlta >= DateTime.Now.AddDays(-30))
                .OrderByDescending(b => b.FechaAlta)
                .ToList();

            List<PropiedadDto> dtos = new List<PropiedadDto>();
            foreach (var propiedad in propiedades)
            {
                dtos.Add(this.ToDto(propiedad));
            }
            return dtos;
        }

        public void Update(Propiedad propiedad)
        {
            using var context = new InmobiliariaContext();

            Propiedad propiedadToUpdate = context.Propiedades.Find(propiedad.Id);

            if (propiedadToUpdate != null)
            {
                propiedadToUpdate.Precio = propiedad.Precio;
                propiedadToUpdate.M2 = propiedad.M2;
                propiedadToUpdate.CantidadHabitaciones = propiedad.CantidadHabitaciones;
                propiedadToUpdate.FechaAlta = propiedad.FechaAlta;
                propiedadToUpdate.Titulo = propiedad.Titulo;
                propiedadToUpdate.Descripcion = propiedad.Descripcion;
                propiedadToUpdate.TipoPropiedad = propiedad.TipoPropiedad;
                context.SaveChanges();
            }
        }

        public PropiedadDto ToDto(Propiedad propiedad)
        {
            PropiedadDto dto = new PropiedadDto();
            dto.Id = propiedad.Id;
            dto.Titulo = propiedad.Titulo;
            dto.Descripcion = propiedad.Descripcion;

            dto.TipoPropiedadId = propiedad.TipoPropiedadId;
            if (propiedad.TipoPropiedad != null)
            {
                dto.TipoPropiedadDescripcion = propiedad.TipoPropiedad.Descripcion;
            }

            dto.CantidadHabitaciones = propiedad.CantidadHabitaciones;
            dto.M2 = propiedad.M2;
            dto.Precio = propiedad.Precio;

            return dto;
        }
    }
}
