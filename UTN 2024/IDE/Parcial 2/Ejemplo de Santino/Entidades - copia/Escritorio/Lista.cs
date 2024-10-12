using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Cataldi.Entidades;
using Negocio;
using Datos;
namespace Escritorio
{
    public partial class Lista : Form
    {
        public Lista()
        {
            InitializeComponent();
            AgregarDatosDePrueba();
            CargarAlumnos();
        }


        public static void AgregarDatosDePrueba()
        {
            var servi = new AlumnoService();
                if (!servi.GetAll().Any()) // Solo agrega si no hay datos
                {
                    servi.Add(new Alumno { ApellidoNombre = "Juan Pérez", Dni = "12345678A", Email = "juan.perez@example.com", FechaNacimiento = new DateTime(2000, 1, 15), NotaPromedio = 8.5m });
                    servi.Add(new Alumno { ApellidoNombre = "Ana Gómez", Dni = "87654321B", Email = "ana.gomez@example.com", FechaNacimiento = new DateTime(1999, 5, 30), NotaPromedio = 9.0m });
                    servi.Add(new Alumno { ApellidoNombre = "Luis Fernández", Dni = "11223344C", Email = "luis.fernandez@example.com", FechaNacimiento = new DateTime(2001, 3, 22), NotaPromedio = 7.0m });
                }
        }
        private void CargarAlumnos()
        {
            var alumnos = AlumnoNegocio.RecuperarTodos(); // Obtener lista de alumnos
            comboBoxAlumnos.DataSource = alumnos.ToList(); // Establecer la lista en el ComboBox
            comboBoxAlumnos.DisplayMember = "ApellidoNombre"; // Mostrar solo el nombre en el ComboBox
            comboBoxAlumnos.ValueMember = "Id"; // Usar el Id para identificar el registro
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBoxAlumnos.SelectedItem != null)
            {
                // Obtener el alumno seleccionado
                Alumno alumnoSeleccionado = (Alumno)comboBoxAlumnos.SelectedItem;

                // Mostrar los datos del alumno en un MessageBox
                string infoAlumno = $"Nombre: {alumnoSeleccionado.ApellidoNombre}\n" +
                                    $"DNI: {alumnoSeleccionado.Dni}\n" +
                                    $"Edad: {alumnoSeleccionado.Edad}\n" +
                                    $"Email: {alumnoSeleccionado.Email}\n" +
                                    $"Fecha de Nacimiento: {alumnoSeleccionado.FechaNacimiento.ToShortDateString()}\n" +
                                    $"Nota Promedio: {alumnoSeleccionado.NotaPromedio}";

                MessageBox.Show(infoAlumno, "Datos del Alumno", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Por favor, seleccione un alumno.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
    }
}
