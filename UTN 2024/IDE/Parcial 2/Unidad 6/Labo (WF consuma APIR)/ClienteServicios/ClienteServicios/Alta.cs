using Entidades;
using Negocio;

namespace ClienteServicios
{
    public partial class Alta : Form
    {
        public Alta()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            Alumno a = new Alumno();
            a.DNI = textBox1.Text;
            a.ApellidoNombre = textBox2.Text;
            a.Email = textBox3.Text;
            a.FechaNacimiento = dateTimePicker1.Value;
            a.NotaPromedio = Convert.ToDecimal(textBox4.Text);

            if (button1.Text == "Modificar")
            {
                await AlumnoNegocio.Update(a);
            }
            else
            {
                await AlumnoNegocio.Add(a);
            }
            Dispose();
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        public Alta(Alumno alumnoAModificar)
        {
            InitializeComponent();
            button1.Text = "Modificar";
            textBox1.Text = alumnoAModificar.DNI;
            textBox1.Enabled = false;
            textBox2.Text = alumnoAModificar.ApellidoNombre;
            textBox3.Text = alumnoAModificar.Email;
            dateTimePicker1.Value = alumnoAModificar.FechaNacimiento;
            textBox4.Text = Convert.ToString(alumnoAModificar.NotaPromedio);
        }
    }
}
