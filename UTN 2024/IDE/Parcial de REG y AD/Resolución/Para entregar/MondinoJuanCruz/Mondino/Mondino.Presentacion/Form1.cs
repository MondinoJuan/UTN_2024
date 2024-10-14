using Mondino.Negocio;

namespace Mondino.Presentacion
{
    public partial class Form1 : Form
    {
        private Task<IEnumerable<Propiedad>>? l;
        public Form1()
        {
            InitializeComponent();
        }

        public IEnumerable<Propiedad> cargarTabla()
        {
            l = PropiedadNegocio.GetAll();
            return l.Result;
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            Task<IEnumerable<Propiedad>> task = new Task<IEnumerable<Propiedad>>(cargarTabla);
            task.Start();
            dataGridView1 = new DataGridView();
        }

        private async void button3_Click(object sender, EventArgs e)
        {
            int filaSeleccionada = dataGridView1.SelectedRows[0].Index;
            await PropiedadNegocio.Delete(l.Result.ToList()[filaSeleccionada]);
            button1_Click(sender, e);
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            new Alta().ShowDialog();
            button1_Click(sender, e);
        }

        private async void button4_Click(object sender, EventArgs e)
        {
            int filaSeleccionada = dataGridView1.SelectedRows[0].Index;
            new Alta(l.Result.ToList()[filaSeleccionada]).ShowDialog();
            button1_Click(sender, e);
        }
    }
}
