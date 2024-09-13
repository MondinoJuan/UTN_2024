namespace MaestroDetale.Models
{
    public class Venta
    {
        public int IdVenta { get; set; }
        public string NroDocumento { get; set; }
        public string RazonSocial { get; set; }
        public decimal Total { get; set; }


        public List<DetalleVenta> lstDetalleVenta { get; set; }
    }
}
