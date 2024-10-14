using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
namespace Datos
{
    public class PracticaService
    {   
        public IEnumerable<Alumno2>?  GetAll()
        {
            using var context = new PracticaContext();
            try
            {
                var alumnos = context.Alumnos.ToList();
                return alumnos;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                var alumnos = new List<Alumno2>();
                return alumnos;
            }

           
        }
        public void Update(Alumno2 alumno)
        {
            using var context = new PracticaContext();
            Alumno2? _aModif = context.Alumnos.Find(alumno.Id);
            if (_aModif != null)
            {
                context.Alumnos.Update(alumno);
                context.SaveChanges();
            }
        }
    }
}
