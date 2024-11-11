using System.Net;

using Jaca.Entidades;
using Jaca.Negocio;

namespace Jaca.Escritorio
{
    public partial class TipoPropiedadUI : Form
    {
        private TipoPropiedad TipoPropiedad;

        public TipoPropiedadUI()
        {
            InitializeComponent();
            TituloLabel.Text = "Nuevo Tipo de Propiedad";
            GuardarButton.Text = "Crear";

        }

        public TipoPropiedadUI(TipoPropiedad tipoPropiedadAModificar)
        {
            InitializeComponent();
            TituloLabel.Text = "Editar Tipo de Propiedad";
            GuardarButton.Text = "Modificar";

            this.TipoPropiedad = tipoPropiedadAModificar;

            DescripcionTextBox.Text = TipoPropiedad.Descripcion;
        }

        private async void GuardarButton_Click(object sender, EventArgs e)
        {
            if (ComprobarCamposRequeridos())
            {
                if (GuardarButton.Text == "Modificar")
                {
                    TipoPropiedadDTO tipoPropiedadModificado = EstablecerDatosTipoPropiedadAModificar();

                    var response = await TipoPropiedadNegocio.Update(TipoPropiedad.Id, tipoPropiedadModificado);

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
                    TipoPropiedad nueviTipoPropiedad = EstablecerDatosNuevoTipoPropiedad();

                    var response = await TipoPropiedadNegocio.Add(nueviTipoPropiedad);

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

        private TipoPropiedadDTO EstablecerDatosTipoPropiedadAModificar()
        {
            TipoPropiedadDTO tipoPropiedad = new TipoPropiedadDTO();

            tipoPropiedad.Descripcion = DescripcionTextBox.Text;

            return tipoPropiedad;
        }

        private TipoPropiedad EstablecerDatosNuevoTipoPropiedad()
        {
            TipoPropiedad tipoPropiedad = new TipoPropiedad(DescripcionTextBox.Text);

            return tipoPropiedad;
        }

        private void CancelarButton_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
        }
    }
}