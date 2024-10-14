using Entidades;
using Newtonsoft;
using Newtonsoft.Json;

namespace Negocio
{
    public class AlumnoNegocio
    {
        static readonly string defaultURL = "https://localhost:7011/api/Alumno/";
        public async static Task<IEnumerable<Alumno>> GetAll()
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync(defaultURL);
            var data = JsonConvert.DeserializeObject<List<Alumno>>(response);
            return data;
        }

        public async static Task<Boolean> Delete (Alumno alumno)
        {
            var response = await Conexion.Instancia.Cliente.DeleteAsync(defaultURL + alumno.DNI);
            return response.IsSuccessStatusCode;
        }

        public async static Task<Boolean> Add(Alumno alumno)
        {
            var response = await Conexion.Instancia.Cliente.PostAsJsonAsync(defaultURL, alumno);
            return response.IsSuccessStatusCode;
        }

        public async static Task<Boolean> Update(Alumno alumno)
        {
            var response = await Conexion.Instancia.Cliente.PutAsJsonAsync(defaultURL + alumno.DNI, alumno);
            return response.IsSuccessStatusCode;
        }
    }
}
