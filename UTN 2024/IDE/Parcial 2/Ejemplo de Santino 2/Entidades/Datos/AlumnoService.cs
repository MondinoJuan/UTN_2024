using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Cataldi.Entidades;

namespace Datos
{
    public class AlumnoService
    {

        public void Add(Alumno alumno)
        {
            using var context = new AlumnoContext();
            context.Alumnos.Add(alumno);
            context.SaveChanges();
        }
        public void Update(Alumno alumno)
        {
            using var context = new AlumnoContext();
            Alumno? alumnoToUpdate =  context.Alumnos.Find(alumno.Id);
            if (alumnoToUpdate != null)
            {
                context.Alumnos.Update(alumno);
                context.SaveChanges();
            }
        }
        public IEnumerable<Alumno> GetAll()
        {
            using var context = new AlumnoContext();
            
            try
            {
                return context.Alumnos.ToList();

            }
            catch(Exception ex) {
                Console.WriteLine($"Hubo un error:{ex.Message} ");
                return new List<Alumno>(); //devuelvo lista vacia si hay un conflicto
            }
        }
        public Alumno? Get(int id)
        {
            using var context = new AlumnoContext();
            return context.Alumnos.Find(id);
        }
        public void Delete(int id)
        {
            using var context = new AlumnoContext();
            Alumno? alumnoToDelete = context.Alumnos.Find(id);
            if (alumnoToDelete != null)
            {
                context.Alumnos.Remove(alumnoToDelete);
                context.SaveChanges();
            }
        }

    }
}
