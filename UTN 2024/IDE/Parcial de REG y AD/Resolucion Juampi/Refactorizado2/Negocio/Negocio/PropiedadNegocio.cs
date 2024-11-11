using Newtonsoft.Json;
using System.Text;
using Jaca.Entidades;
using System.Net.Http.Json;

namespace Jaca.Negocio
{
    public class PropiedadNegocio
    {
        static readonly string defaultURL = "https://localhost:7268/api/Propiedad/";

        public async static Task<IEnumerable<Propiedad>> GetAll()
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync(defaultURL);

            var data = JsonConvert.DeserializeObject<IEnumerable<Propiedad>>(response);

            return data;
        }

        public async static Task<Propiedad> GetOne(int id)
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync($"{defaultURL}{id}");

            var data = JsonConvert.DeserializeObject<Propiedad>(response);

            return data;
        }

        public async static Task<HttpResponseMessage> Add(Propiedad propiedad)
        {
            var response = await Conexion.Instancia.Cliente.PostAsJsonAsync(defaultURL, propiedad);

            return response;
        }

        public async static Task<HttpResponseMessage> Update(int id, PropiedadDTO propiedadDTO)
        {
            var json = JsonConvert.SerializeObject(propiedadDTO);

            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await Conexion.Instancia.Cliente.PatchAsync($"{defaultURL}{id}", content);

            return response;
        }

        public async static Task<HttpResponseMessage> Delete(Propiedad propiedad)
        {
            var response = await Conexion.Instancia.Cliente.DeleteAsync($"{defaultURL}{propiedad.Id}");

            return response;
        }
    }
}