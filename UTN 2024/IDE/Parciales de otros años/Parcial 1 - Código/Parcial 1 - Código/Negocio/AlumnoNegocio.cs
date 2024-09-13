using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using BaseDeDatos;


namespace Negocio
{
    public class AlumnoNegocio
    {
        public static List<Alumno> TraerTodos()
        {
            AdaptadorAlumno datos = new AdaptadorAlumno();
            return datos.TraerTodos();
        }

        public Alumno TraerUno(int id)
        {
            AdaptadorAlumno datos = new AdaptadorAlumno();
            return datos.TraerUno(id);
        }
    }
}
