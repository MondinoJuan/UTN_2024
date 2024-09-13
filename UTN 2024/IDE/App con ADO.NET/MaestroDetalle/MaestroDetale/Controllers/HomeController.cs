using MaestroDetale.Models;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

using System.Xml.Linq;

namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        private readonly string _cadenaSql;

        public HomeController(IConfiguration config)
        {
            _cadenaSql = config.GetConnectionString("CadenaSQL");
        }

        public IActionResult Index()
        {

            return View();
        }

        //reference models
        //reference System.Xml.Linq;
        [HttpPost]
        public JsonResult GuardarVenta([FromBody] Venta body)
        {

            XElement venta = new XElement("Venta",
                new XElement("NumeroDocumento", body.NroDocumento),
                new XElement("RazonSocial", body.RazonSocial),
                new XElement("Total", body.Total)
            );

            XElement oDetalleVenta = new XElement("DetalleVenta");
            foreach (DetalleVenta item in body.lstDetalleVenta)
            {
                oDetalleVenta.Add(new XElement("Item",
                    new XElement("Producto", item.Producto),
                    new XElement("Precio", item.Precio),
                    new XElement("Cantidad", item.Cantidad),
                    new XElement("Total", item.Total)
                    ));
            }
            venta.Add(oDetalleVenta);

            using (var conexion = new MySqlConnection(_cadenaSql))
            {
                conexion.Open();
                using (var cmd = new MySqlCommand("sp_guardarVenta", conexion))
                {
                    cmd.Parameters.Add(new MySqlParameter("@venta_xml", MySqlDbType.VarChar) { Value = venta.ToString() });
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }

            return Json(new { respuesta = true });
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}