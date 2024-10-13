using Entidades;
using Newtonsoft;
using Newtonsoft.Json;

namespace Negocio
{
    public class AlumnoNegocio
    {
        public async static Task<IEnumerable<Alumno>> GetAll()
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync("https://localhost:7011/api/Alumno/");
            var data = JsonConvert.DeserializeObject<List<Alumno>>(response);
            return data;
        }

        public async static Task<Boolean> Delete (Alumno alumno)
        {
            var response = await Conexion.Instancia.Cliente.DeleteAsync("https://localhost:7011/api/Alumno/" + alumno.DNI);
            return response.IsSuccessStatusCode;
        }
    }
}
