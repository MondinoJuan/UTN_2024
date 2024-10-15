using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Mondino.Negocio;

namespace Mondino.Web
{
    [ApiController]
    [Route("api/[controller]")]
    public class PropiedadControllers : Controller
    {
        private readonly PropiedadContext _context;

        public PropiedadControllers(PropiedadContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetPropiedades")]
        public ActionResult<IEnumerable<Propiedad>> GetAll()
        {
            return _context.Propiedades.ToList();
        }

        [HttpGet("{Id}")]
        public ActionResult<Propiedad> GetById(long Id)
        {
            var propiedad = _context.Propiedades.Find(Id);
            if (propiedad == null)
            {
                return NotFound();
            }
            return propiedad;
        }

        [HttpPost]
        public ActionResult<Propiedad> Create(Propiedad propiedad)
        {
            _context.Propiedades.Add(propiedad);
            _context.SaveChanges();

            return CreatedAtAction(nameof(GetById), new { Id = propiedad.Id }, propiedad);
        }

        [HttpPut("{Id}")]
        public IActionResult Update(long Id, Propiedad propiedad)
        {
            if (Id != propiedad.Id)
            {
                return BadRequest();
            }

            _context.Entry(propiedad).State = EntityState.Modified;
            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{Id}")]
        public IActionResult Delete(long Id)
        {
            var propiedad = _context.Propiedades.Find(Id);
            if (propiedad == null)
            {
                return NotFound();
            }

            _context.Propiedades.Remove(propiedad);
            _context.SaveChanges();

            return NoContent();
        }
    }
}

