namespace Mondino.Forms
{
    public partial class ListarProd : Form
    {
        public ListarProd()
        {
            InitializeComponent();
            this.GetAllAndLoad();
        }

        private void btnAgregarProd_Click(object sender, EventArgs e)
        {
            AgregoProducto productoDetalle = new AgregoProducto();

            Producto productoNuevo = new Producto();

            productoDetalle.producto = productoNuevo;

            productoDetalle.ShowDialog();

            this.GetAllAndLoad();
        }

        private async void GetAllAndLoad()
        {
            ProductoApiClient client = new ProductoApiClient();

            this.dgvProductos.DataSource = null;
            this.dgvProductos.DataSource = await ProductoApiClient.GetAllAsync();
            this.dgvProductos.Rows[0].Selected = true;
        
        }

        private void Productos_Load(object sender, EventArgs e)
        {
            this.GetAllAndLoad();
        }
    }
}
