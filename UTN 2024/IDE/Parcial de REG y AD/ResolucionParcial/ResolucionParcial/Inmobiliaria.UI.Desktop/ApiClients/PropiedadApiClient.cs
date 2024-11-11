using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace Inmobiliaria.UI.Desktop.ApiCliients
{
    public class PropiedadApiClient
    {
        private static HttpClient client = new HttpClient();
        static PropiedadApiClient()
        {
            // Esta URL se podría pasar a un setting
            client.BaseAddress = new Uri("https://localhost:7106/");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
        }
        public static async Task<PropiedadDto> GetAsync(int id)
        {
            PropiedadDto propiedadDto = null;
            HttpResponseMessage response = await client.GetAsync("propiedades/" + id);
            if (response.IsSuccessStatusCode)
            {
                propiedadDto = await response.Content.ReadAsAsync<PropiedadDto>();
            }
            return propiedadDto;
        }

        public static async Task<IEnumerable<PropiedadDto>> GetAllAsync()
        {
            IEnumerable<PropiedadDto> entities = null;
            HttpResponseMessage response = await client.GetAsync("propiedades");

            if (response.IsSuccessStatusCode)
            {
                entities = await response.Content.ReadAsAsync<IEnumerable<PropiedadDto>>();
            }
            return entities;
        }

        public static async Task AddAsync(PropiedadDto propiedadDto)
        {
            HttpResponseMessage response = await client.PostAsJsonAsync("propiedades", propiedadDto);
            response.EnsureSuccessStatusCode();
        }

        public static async Task DeleteAsync(int id)
        {
            HttpResponseMessage response = await client.DeleteAsync("propiedades/" + id);
            response.EnsureSuccessStatusCode();
        }

        public static async Task UpdateAsync(PropiedadDto propiedadDto)
        {
            HttpResponseMessage response = await client.PutAsJsonAsync("propiedades", propiedadDto);
            response.EnsureSuccessStatusCode();
        }
    }
}
