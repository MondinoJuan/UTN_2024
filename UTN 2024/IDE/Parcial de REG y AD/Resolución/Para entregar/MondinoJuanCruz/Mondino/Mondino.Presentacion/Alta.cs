using Mondino.Negocio;

namespace Mondino.Presentacion
{
    public partial class Alta : Form
    {
        public Alta()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            Propiedad p = new Propiedad();
            p.Id = int.Parse(textBox1.Text);
            p.TipoPropiedad = int.Parse(textBox2.Text);
            p.Titulo = textBox3.Text;            
            p.Descripcion = textBox4.Text;
            p.CantidadHabitaciones = int.Parse(textBox5.Text);
            p.M2 = int.Parse(textBox6.Text);
            p.Precio = Convert.ToDecimal(textBox7.Text);
            p.FechaAlta = dateTimePicker1.Value;

            if (button1.Text == "Modificar")
            {
                await PropiedadNegocio.Update(p);
            }
            else
            {
                await PropiedadNegocio.Add(p);
            }
            Dispose();
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        public Alta(Propiedad propiedadAModificar)
        {
            InitializeComponent();
            button1.Text = "Modificar";
            textBox1.Text = Convert.ToString(propiedadAModificar.Id);
            textBox1.Enabled = false;
            textBox2.Text = Convert.ToString(propiedadAModificar.TipoPropiedad);
            textBox3.Text = propiedadAModificar.Titulo;
            textBox4.Text = propiedadAModificar.Descripcion;
            textBox5.Text = Convert.ToString(propiedadAModificar.CantidadHabitaciones);
            textBox6.Text = Convert.ToString(propiedadAModificar.M2);
            textBox7.Text = Convert.ToString(propiedadAModificar.Precio);
            dateTimePicker1.Value = propiedadAModificar.FechaAlta;
        }
    }
}
