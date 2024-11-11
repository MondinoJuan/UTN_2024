using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace Mondino.Forms
{
    public class ProductoApiClient
    {
        private static HttpClient client = new HttpClient();

        static ProductoApiClient()
        {
            client.BaseAddress = new Uri("https://localhost:7290/");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public static async Task<IEnumerable<Producto>> GetAllAsync()
        {
            IEnumerable<Producto> productos = null;
            HttpResponseMessage response = await client.GetAsync("productos");
            if (response.IsSuccessStatusCode)
            {
                productos = await response.Content.ReadAsAsync<IEnumerable<Producto>>();
            }
            return productos;
        }

        public static async Task AddAsync(Producto producto)
        {
            HttpResponseMessage response = await client.PostAsJsonAsync("productos", producto);
            response.EnsureSuccessStatusCode();
        }
    }
}
