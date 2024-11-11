using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Jaca.Datos;
using Jaca.Entidades;

namespace Jaca.Servicios
{
    [ApiController]
    [Route("api/[controller]")]
    public class PropiedadController : ControllerBase
    {
        private readonly InmobiliariaContext _context;

        public PropiedadController(InmobiliariaContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetPropiedad")]
        public ActionResult<IEnumerable<Propiedad>> GetAll()
        {
            try
            {
                var fechaLimite = DateTime.Now.AddDays(-30);

                return _context.Propiedades
                    .Include(prop => prop.TipoPropiedad)
                    .Where(prop => prop.FechaAlta >= fechaLimite)
                    .OrderByDescending(prop => prop.FechaAlta)
                    .ToList();
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpGet("{id}")]
        public ActionResult<Propiedad> GetById(int id)
        {
            try
            {
                var Propiedad = _context.Propiedades.Find(id);

                if (Propiedad == null)
                {
                    return NotFound();
                }

                return Propiedad;

            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpPost]
        public ActionResult<Propiedad> Create(PropiedadDTO propiedadDTO)
        {
            try
            {
                Propiedad nuevaPropiedad = new Propiedad(propiedadDTO.IdTipoPropiedad, propiedadDTO.Titulo, propiedadDTO.Descripcion, propiedadDTO.CantidadHabitaciones, propiedadDTO.M2, propiedadDTO.Precio);

                _context.Propiedades.Add(nuevaPropiedad);
                _context.SaveChanges();

                return CreatedAtAction("GetById", new { id = nuevaPropiedad.Id }, nuevaPropiedad);

            }
            catch (DbUpdateException)
            {
                return StatusCode(StatusCodes.Status400BadRequest);
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpPatch("{id}")]
        public ActionResult<Propiedad> Update(int id, [FromBody] PropiedadDTO comisionDTO)
        {
            try
            {
                var Propiedad = _context.Propiedades.Find(id);

                if (Propiedad == null)
                {
                    return NotFound();
                }

                Propiedad.IdTipoPropiedad = comisionDTO.IdTipoPropiedad;
                Propiedad.Titulo = comisionDTO.Titulo;
                Propiedad.Descripcion = comisionDTO.Descripcion;
                Propiedad.CantidadHabitaciones = comisionDTO.CantidadHabitaciones;
                Propiedad.M2 = comisionDTO.M2;
                Propiedad.Precio = comisionDTO.Precio;
                Propiedad.FechaAlta = comisionDTO.FechaAlta;

                _context.Entry(Propiedad).State = EntityState.Modified;
                _context.SaveChanges();

                return Propiedad;

            }
            catch (DbUpdateException)
            {
                return StatusCode(StatusCodes.Status400BadRequest);
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpDelete("{id}")]
        public ActionResult<Propiedad> Delete(int id)
        {
            try
            {
                var Propiedad = _context.Propiedades.Find(id);
                if (Propiedad == null)
                {
                    return NotFound();
                }

                _context.Propiedades.Remove(Propiedad);
                _context.SaveChanges();

                return Propiedad;
            }
            catch (DbUpdateException)
            {
                return StatusCode(StatusCodes.Status400BadRequest);
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }
    }
}