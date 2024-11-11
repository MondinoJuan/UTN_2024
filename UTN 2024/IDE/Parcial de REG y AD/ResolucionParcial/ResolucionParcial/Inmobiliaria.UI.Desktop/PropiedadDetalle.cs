using Inmobiliaria.UI.Desktop.ApiCliients;

namespace Inmobiliaria.UI.Desktop
{
    public partial class PropiedadDetalle : Form
    {
        private PropiedadDto propiedad;

        public PropiedadDto Propiedad
        {
            get { return propiedad; }
            set
            {
                propiedad = value;
                this.SetPropiedad();
            }
        }
        public bool EditMode { get; set; } = false;

        public void SetPropiedad()
        {
            if (this.EditMode)
            {
                this.nudPrecio.Value = this.propiedad.Precio;
                this.nudM2.Value = this.propiedad.M2;
                this.nudCantidadHabilitaciones.Value = this.propiedad.CantidadHabitaciones;
                this.txtTitulo.Text = this.propiedad.Titulo;
                this.txtDescripcion.Text = this.propiedad.Descripcion;
                this.cboTipoPropiedades.SelectedValue = this.propiedad.TipoPropiedadId;
                this.lblFechaAlta.Text = this.propiedad.FechaAlta.ToString ("dd/MM/yyyy hh:mm");

            }
        }
        public PropiedadDetalle()
        {
            this.InitializeComponent();
        }

        private async void PropiedadDetalle_Load(object sender, EventArgs e)
        {
            var tipoPropiedades = await TipoPropiedadApiClient.GetAllAsync();
            // Mostrar la descripción en el ComboBox
            this.cboTipoPropiedades.DisplayMember = "Descripcion";
            this.cboTipoPropiedades.ValueMember = "Id";
            // Se podría agregar un valor vacio para que la lista no arranque con valor
            this.cboTipoPropiedades.DataSource = tipoPropiedades;
        }

        private void btnCancelar_click(object sender, EventArgs e)
        {
            this.Close();
        }

        private async void btnGuardar_Click(object sender, EventArgs e)
        {
            if (this.ValidatePropiedad())
            {
                this.propiedad.Precio = this.nudPrecio.Value;
                this.propiedad.M2 = Convert.ToInt32(this.nudM2.Value);
                this.propiedad.CantidadHabitaciones = Convert.ToInt32(this.nudCantidadHabilitaciones.Value);
                // Esta valor lo setamos en el backend
                //this.propiedad.FechaAlta = DateTime.Now;
                this.propiedad.Titulo = this.txtTitulo.Text;
                this.propiedad.Descripcion = this.txtDescripcion.Text;
                this.propiedad.TipoPropiedadId = Convert.ToInt32(this.cboTipoPropiedades.SelectedValue);

                if (this.EditMode)
                {
                    await PropiedadApiClient.UpdateAsync(this.propiedad);
                }
                else
                {
                    await PropiedadApiClient.AddAsync(this.propiedad);
                }

                this.Close();
            }
        }

        /// <summary>
        /// Ejemplo de validación del lado del frontend.
        /// </summary>
        /// <returns></returns>
        private bool ValidatePropiedad()
        {
            bool isValid = true;

            this.errorProvider.SetError(this.txtDescripcion, string.Empty);

            if (String.IsNullOrEmpty(this.txtDescripcion.Text))
            {
                isValid = false;
                this.errorProvider.SetError(this.txtDescripcion, "La Descripcíón es requerida.");
            }

            return isValid;
        }

    }
}
