namespace Escritorio
{
    public partial class Principal : Form
    {
        public Principal()
        {
            InitializeComponent();
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            Lista listaForm = new Lista(); // Crea una instancia del formulario Lista
            listaForm.Show(); // Muestra el formulario
        }
    }
}
