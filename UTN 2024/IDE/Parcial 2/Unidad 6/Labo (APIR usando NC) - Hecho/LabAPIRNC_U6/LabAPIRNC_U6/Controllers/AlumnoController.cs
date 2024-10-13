using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LabAPIRNC_U6.Context;
using LabAPIRNC_U6.Models;


namespace LabAPIRNC_U6.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AlumnoController : ControllerBase
    {
        private readonly MyDbContext _context;

        public AlumnoController(MyDbContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetAlumnos")]
        public ActionResult<IEnumerable<Alumno>> GetAll()
        {
            return _context.Alumnos.ToList();
        }

        [HttpGet("{DNI}")]
        public ActionResult<Alumno> GetById(string DNI)
        {
            var alumno = _context.Alumnos.Find(DNI);
            if (alumno == null)
            {
                return NotFound();
            }
            return alumno;
        }

        [HttpPost]
        public ActionResult<Alumno> Create(Alumno alumno)
        {
            _context.Alumnos.Add(alumno);
            _context.SaveChanges();

            return CreatedAtAction(nameof(GetById), new { DNI = alumno.DNI }, alumno);
        }

        [HttpPut("{DNI}")]
        public IActionResult Update(string DNI, Alumno alumno)
        {
            if (DNI != alumno.DNI)
            {
                return BadRequest();
            }

            _context.Entry(alumno).State = EntityState.Modified;
            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{DNI}")]
        public IActionResult Delete(string DNI)
        {
            var alumno = _context.Alumnos.Find(DNI);
            if (alumno == null)
            {
                return NotFound();
            }

            _context.Alumnos.Remove(alumno);
            _context.SaveChanges();

            return NoContent();
        }
    }
}
