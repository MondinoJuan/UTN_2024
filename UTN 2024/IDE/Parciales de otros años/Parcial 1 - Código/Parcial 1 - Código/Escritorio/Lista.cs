using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Negocio;
using Entidades;

namespace Escritorio
{
    public partial class Lista : Form
    {
        public Lista()
        {
            InitializeComponent();
            CargarCombo();
        }

        protected void CargarCombo()
        {
            cbAlumnos.DataSource = AlumnoNegocio.TraerTodos();
            cbAlumnos.DisplayMember = "ApellidoNombre";
            cbAlumnos.ValueMember = "Id";
            cbAlumnos.SelectedIndex = -1;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            AlumnoNegocio al = new AlumnoNegocio();
            if (cbAlumnos.SelectedItem != null)
            {
                MessageBox.Show(AlumnoATexto(al.TraerUno(Convert.ToInt32(cbAlumnos.SelectedValue))));
            }
            else
            {
                MessageBox.Show("No hay ningun alumno seleccionado");
            }
                
        }

        public string AlumnoATexto(Alumno alumno)
        {
            String cadena = "Estos son los datos del alumno: \n";
            cadena += "ID: " + alumno.Id + "\n";
            cadena += "Apellido y Nombre: " + alumno.ApellidoNombre + "\n";
            cadena += "Edad: " + alumno.Edad.ToString() + "\n";
            cadena += "Correo electrónico: " + alumno.Email + "\n";

            return cadena;
        }
    }
}
