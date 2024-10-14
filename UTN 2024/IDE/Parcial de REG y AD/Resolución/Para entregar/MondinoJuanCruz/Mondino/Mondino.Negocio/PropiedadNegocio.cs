using Newtonsoft.Json;

namespace Mondino.Negocio
{
    public class PropiedadNegocio
    {
        static readonly string defaultURL = "http://localhost:5072/api/Propiedad/";
        public async static Task<IEnumerable<Propiedad>> GetAll()
        {
            var response = await Conexion.Instancia.Cliente.GetStringAsync(defaultURL);
            var data = JsonConvert.DeserializeObject<List<Propiedad>>(response);
            return data;
        }

        public async static Task<Boolean> Delete(Propiedad propiedad)
        {
            var response = await Conexion.Instancia.Cliente.DeleteAsync(defaultURL + propiedad.Id);
            return response.IsSuccessStatusCode;
        }

        public async static Task<Boolean> Add(Propiedad propiedad)
        {
            var response = await Conexion.Instancia.Cliente.PostAsJsonAsync(defaultURL, propiedad);
            return response.IsSuccessStatusCode;
        }

        public async static Task<Boolean> Update(Propiedad propiedad)
        {
            var response = await Conexion.Instancia.Cliente.PutAsJsonAsync(defaultURL + propiedad.Id, propiedad);
            return response.IsSuccessStatusCode;
        }
    }
}
