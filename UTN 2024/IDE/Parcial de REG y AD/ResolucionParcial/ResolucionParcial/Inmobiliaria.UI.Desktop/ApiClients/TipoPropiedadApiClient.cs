using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace Inmobiliaria.UI.Desktop.ApiCliients
{
    public class TipoPropiedadApiClient
    {
        private static HttpClient client = new HttpClient();
        static TipoPropiedadApiClient()
        {
            // Esta URL se podría pasar a un setting
            client.BaseAddress = new Uri("https://localhost:7106/");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public static async Task<IEnumerable<TipoPropiedadDto>> GetAllAsync()
        {
            IEnumerable<TipoPropiedadDto> entities = null;
            HttpResponseMessage response = await client.GetAsync("tipos-propiedades");
            if (response.IsSuccessStatusCode)
            {
                entities = await response.Content.ReadAsAsync<IEnumerable<TipoPropiedadDto>>();
            }
            return entities;
        }
    }
}
