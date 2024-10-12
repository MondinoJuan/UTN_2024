using Domain.Model;

namespace Domain.Services
{
    public class ClienteService 
    {
        public void Add(Cliente cliente)
        {
            using var context = new ClienteContext();

            context.Clientes.Add(cliente);
            context.SaveChanges();
        }

        public void Delete(int id)
        {
            using var context = new ClienteContext();

            Cliente? clienteToDelete = context.Clientes.Find(id);

            if (clienteToDelete != null)
            {
                context.Clientes.Remove(clienteToDelete);
                context.SaveChanges();
            }
        }

        public Cliente? Get(int id)
        {
            using var context = new ClienteContext();

            return context.Clientes.Find(id);
        }

        public IEnumerable<Cliente> GetAll()
        {
            using var context = new ClienteContext();

            return context.Clientes.ToList();
        }

        public void Update(Cliente cliente)
        {
            using var context = new ClienteContext();

            Cliente? clienteToUpdate = context.Clientes.Find(cliente.Id);

            if (clienteToUpdate != null)
            {
                clienteToUpdate.Nombre = cliente.Nombre;
                context.SaveChanges();
            }
        }
    }
}
