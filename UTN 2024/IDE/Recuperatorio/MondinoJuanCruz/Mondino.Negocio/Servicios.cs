namespace Mondino.Negocio
{
    public class Servicios
    {
        public static void CrearProducto(Producto producto)
        {

            using var context = new RecuContext();
            context.Productos.Add(producto);
            context.SaveChanges();

        }

        public static IEnumerable<Producto> GetAllProductos()
        {
            using var context = new RecuContext();

            return context.Productos.ToList();
        }

        public static void ActualizarProducto(Producto producto)
        {
            using var context = new RecuContext();

            var productoToUpdate = context.Productos.Find(producto.Id);

            if (productoToUpdate != null)
            {
                productoToUpdate.Codigo = producto.Codigo;
                productoToUpdate.Descripcion = producto.Descripcion;
                productoToUpdate.Precio = producto.Precio;
                context.SaveChanges();
            }
        }
    }

}

