using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Jaca.Datos;
using Jaca.Entidades;

namespace Servicios
{
    [ApiController]
    [Route("api/[controller]")]
    public class TipoPropiedadController : ControllerBase
    {
        private readonly InmobiliariaContext _context;

        public TipoPropiedadController(InmobiliariaContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetTipoPropiedad")]
        public ActionResult<IEnumerable<TipoPropiedad>> GetAll()
        {
            try
            {
                return _context.TiposPropiedades.ToList();
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpGet("{id}")]
        public ActionResult<TipoPropiedad> GetById(int id)
        {
            try
            {
                var TipoPropiedad = _context.TiposPropiedades.Find(id);

                if (TipoPropiedad == null)
                {
                    return NotFound();
                }

                return TipoPropiedad;

            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable);
            }
        }

        [HttpPost]
        public ActionResult<TipoPropiedad> Create(TipoPropiedadDTO tipoPropiedadDTO)
        {
            try
            {
                TipoPropiedad nuevoTipoPropiedad = new TipoPropiedad(tipoPropiedadDTO.Descripcion);

                _context.TiposPropiedades.Add(nuevoTipoPropiedad);
                _context.SaveChanges();

                return CreatedAtAction("GetById", new { id = nuevoTipoPropiedad.Id }, nuevoTipoPropiedad);

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
        public ActionResult<TipoPropiedad> Update(int id, [FromBody] TipoPropiedadDTO tipoPropiedadDTO)
        {
            try
            {
                var TipoPropiedad = _context.TiposPropiedades.Find(id);

                if (TipoPropiedad == null)
                {
                    return NotFound();
                }

                TipoPropiedad.Descripcion = tipoPropiedadDTO.Descripcion;

                _context.Entry(TipoPropiedad).State = EntityState.Modified;
                _context.SaveChanges();

                return TipoPropiedad;

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
        public ActionResult<TipoPropiedad> Delete(int id)
        {
            try
            {
                var TipoPropiedad = _context.TiposPropiedades.Find(id);
                if (TipoPropiedad == null)
                {
                    return NotFound();
                }

                _context.TiposPropiedades.Remove(TipoPropiedad);
                _context.SaveChanges();

                return TipoPropiedad;
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