namespace Mondino.Forms
{
    public partial class AgregoProducto : Form
    {
        public AgregoProducto()
        {
            InitializeComponent();
        }

        public Producto producto;

        private async void btnAceptar_Click(object sender, EventArgs e)
        {
                    if (this.producto == null)
                    {
                        this.producto = new Producto();
                    }

                    this.producto.Codigo = txtbCodigo.Text;
                    this.producto.Descripcion = txtbDesc.Text;
                    this.producto.Precio = decimal.Parse(txtbPrecio.Text);

                    await ProductoApiClient.AddAsync(this.producto);

                    this.Close();
        }

        private void SetProducto()
        {
            this.txtbCodigo.Text = this.producto.Codigo;
            this.txtbDesc.Text = this.producto.Descripcion;
            //this.txtbPrecio.Text = this.producto.Precio;

        }
    }
}
