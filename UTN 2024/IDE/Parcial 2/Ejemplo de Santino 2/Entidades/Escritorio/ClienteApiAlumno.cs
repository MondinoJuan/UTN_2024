using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// La que se agregan
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Threading.Tasks;
using System.Net;
using Cataldi.Entidades;

namespace Escritorio
{
    class ClienteApiAlumno
    {
        //realizo la conexion a la api
        private static HttpClient client = new HttpClient();

        static ClienteApiAlumno()
        {
            client.BaseAddress = new Uri("http://localhost:5177");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public static async Task<IEnumerable<Alumno>> GetAll()
        {
            IEnumerable<Alumno> alumnos = null;
            HttpResponseMessage response = await client.GetAsync("alumnos");
            if (response.IsSuccessStatusCode)
            {
                alumnos = await response.Content.ReadFromJsonAsync<IEnumerable<Alumno>>();
            }
            return alumnos;
        }
    }
}
