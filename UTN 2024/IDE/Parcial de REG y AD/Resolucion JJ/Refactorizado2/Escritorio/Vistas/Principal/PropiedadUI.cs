using System.Net;

using Jaca.Entidades;
using Jaca.Negocio;

namespace Jaca.Escritorio
{

    public partial class PropiedadUI : Form
    {
        public Propiedad Propiedad { get; set; }

        private List<(int Id, string Descripcion)> TiposPropiedades;

        public PropiedadUI(List<(int Id, string Descripcion)> tiposPropiedades)
        {
            InitializeComponent();

            TituloVentanaLabel.Text = "Nueva Propiedad";
            GuardarButton.Text = "Crear";

            this.TiposPropiedades = tiposPropiedades;

            List<string> listadoTiposPropiedades = ListadoNombresTiposPropiedades();

            TipoPropiedadComboBox.DataSource = listadoTiposPropiedades;
        }

        public PropiedadUI(List<(int Id, string Descripcion)> tiposPropiedades, Propiedad propiedadAModificar)
        {
            InitializeComponent();

            TituloVentanaLabel.Text = "Editar Propiedad";
            GuardarButton.Text = "Modificar";

            this.TiposPropiedades = tiposPropiedades;
            this.Propiedad = propiedadAModificar;

            TituloTextBox.Text = propiedadAModificar.Titulo;
            DescripcionTextBox.Text = propiedadAModificar.Descripcion;
            CantidadHabitacionesTextBox.Text = propiedadAModificar.CantidadHabitaciones.ToString();
            M2TextBox.Text = propiedadAModificar.M2.ToString();
            PrecioTextBox.Text = propiedadAModificar.Precio.ToString();
      
            TipoPropiedadComboBox.DataSource = ListadoNombresTiposPropiedades();

            foreach (var tipoPropiedad in this.TiposPropiedades)
            {
                if (tipoPropiedad.Id == propiedadAModificar.IdTipoPropiedad)
                {
                    TipoPropiedadComboBox.SelectedItem = tipoPropiedad.Descripcion;
                }
            }
        }

        private async void GuardarButton_Click(object sender, EventArgs e)
        {
            if (ComprobarCamposRequeridos())
            {
                if (GuardarButton.Text == "Modificar")
                {
                    PropiedadDTO propiedadModificada = EstablecerDatosPropiedadAModificar();

                    var response = await PropiedadNegocio.Update(Propiedad.Id, propiedadModificada);

                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        DialogResult = DialogResult.OK;
                    }
                    else
                    {
                        DialogResult = DialogResult.Cancel;
                    }
                }
                else
                {
                    Propiedad nuevaPropiedad = EstablecerDatosNuevaPropiedad();

                    var response = await PropiedadNegocio.Add(nuevaPropiedad);

                    if (response.StatusCode == HttpStatusCode.Created)
                    {
                        DialogResult = DialogResult.OK;
                    }
                    else
                    {
                        DialogResult = DialogResult.Cancel;
                    }
                }
            }
        }

        private bool ComprobarCamposRequeridos()
        {
            foreach (Control control in this.Controls.Cast<Control>().OrderBy(c => c.TabIndex))
            {
                if (control is TextBox textBox)
                {
                    if (string.IsNullOrEmpty(textBox.Text))
                    {
                        CampoRequerido campoRequerido = new CampoRequerido();
                        campoRequerido.CampoRequeridoLabel.Text = campoRequerido.CampoRequeridoLabel.Text.Replace("${campo}", textBox.Name.Replace("TextBox", ""));
                        campoRequerido.ShowDialog(this);

                        DialogResult = DialogResult.None;
                        return false;
                    }
                }
            }

            return true;

        }

        private PropiedadDTO EstablecerDatosPropiedadAModificar()
        {
            int idTipoPropiedadSeleccionado = ObtenerIdTipoPropiedadSeleccionado();

            PropiedadDTO propiedad = new PropiedadDTO();

            propiedad.Titulo = TituloTextBox.Text;
            propiedad.Descripcion = DescripcionTextBox.Text;
            propiedad.CantidadHabitaciones = Int32.Parse(CantidadHabitacionesTextBox.Text);
            propiedad.M2 = Int32.Parse(M2TextBox.Text);
            propiedad.Precio = decimal.Parse(PrecioTextBox.Text);
            propiedad.IdTipoPropiedad = idTipoPropiedadSeleccionado;

            return propiedad;
        }

        private Propiedad EstablecerDatosNuevaPropiedad()
        {
            int idTipoPropiedadSeleccionado = ObtenerIdTipoPropiedadSeleccionado();

            Propiedad propiedad = new Propiedad(idTipoPropiedadSeleccionado, TituloTextBox.Text, DescripcionTextBox.Text, Int32.Parse(CantidadHabitacionesTextBox.Text), Int32.Parse(M2TextBox.Text), decimal.Parse(PrecioTextBox.Text));

            return propiedad;
        }

        private int ObtenerIdTipoPropiedadSeleccionado()
        {
           int idTipoPropiedadSeleccionado = 0;

            foreach (var tipoPropiedad in this.TiposPropiedades)
            {
                if (tipoPropiedad.Descripcion == TipoPropiedadComboBox.SelectedValue.ToString())
                {
                    idTipoPropiedadSeleccionado = tipoPropiedad.Id;
                }
            }

            return idTipoPropiedadSeleccionado;
        }

        private List<string> ListadoNombresTiposPropiedades()
        {
            List<string> listadoNombresTiposPropiedades = this.TiposPropiedades.Select(tipoPropiedad => tipoPropiedad.Descripcion).ToList();

            listadoNombresTiposPropiedades.Sort();

            return listadoNombresTiposPropiedades;
        }

        private void CancelarButton_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
        }
    }
}