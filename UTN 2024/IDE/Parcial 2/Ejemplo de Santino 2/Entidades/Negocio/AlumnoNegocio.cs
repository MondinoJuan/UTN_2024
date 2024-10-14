
using Cataldi.Entidades;

namespace Negocio
{
    public class AlumnoNegocio
    {
        public static IEnumerable<Alumno> RecuperarTodos()
        {
            var servicio = new Datos.AlumnoService();
            return servicio.GetAll();
        }
    }
}
