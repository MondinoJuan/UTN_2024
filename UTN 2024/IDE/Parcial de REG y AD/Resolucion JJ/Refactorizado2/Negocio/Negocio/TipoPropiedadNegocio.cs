using Newtonsoft.Json;
using System.Text;
using Jaca.Entidades;
using System.Net.Http.Json;

namespace Jaca.Negocio
{
    public class TipoPropiedadNegocio
    {
        static readonly string defaultURL = "https://localhost:7268/api/TipoPropiedad/";

        public async static Task<IEnumerable<TipoPropiedad>> GetAll()
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync(defaultURL);

            var data = JsonConvert.DeserializeObject<IEnumerable<TipoPropiedad>>(response);

            return data;
        }

        public async static Task<TipoPropiedad> GetOne(int id)
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync($"{defaultURL}{id}");

            var data = JsonConvert.DeserializeObject<TipoPropiedad>(response);

            return data;
        }

        public async static Task<HttpResponseMessage> Add(TipoPropiedad tipoPropiedad)
        {
            var response = await Conexion.Instancia.Cliente.PostAsJsonAsync(defaultURL, tipoPropiedad);

            return response;
        }

        public async static Task<HttpResponseMessage> Update(int id, TipoPropiedadDTO tipoPropiedadDTO)
        {
            var json = JsonConvert.SerializeObject(tipoPropiedadDTO);

            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await Conexion.Instancia.Cliente.PatchAsync($"{defaultURL}{id}", content);

            return response;
        }

        public async static Task<HttpResponseMessage> Delete(TipoPropiedad tipoPropiedad)
        {
            var response = await Conexion.Instancia.Cliente.DeleteAsync($"{defaultURL}{tipoPropiedad.Id}");

            return response;
        }
    }
}
