using Inmobiliaria.UI.Desktop.ApiCliients;


namespace Inmobiliaria.UI.Desktop
{
    public partial class PropiedadLista : Form
    {
        public PropiedadLista()
        {
            this.InitializeComponent();
        }

        private void PropiedadLista_Load(object sender, EventArgs e)
        {
            this.GetAllAndLoad();
        }

        private void btnAgregar_click(object sender, EventArgs e)
        {
            try
            {
                PropiedadDetalle propiedadDetalle = new PropiedadDetalle();

                PropiedadDto propiedadNuevo = new PropiedadDto();

                propiedadDetalle.Propiedad = propiedadNuevo;

                propiedadDetalle.ShowDialog();

                this.GetAllAndLoad();
            }
            catch (Exception ex)
            {
                this.ProcesarError(ex);
            }
        }

        private async void btnModificar_click(object sender, EventArgs e)
        {
            try
            {
                PropiedadDetalle propiedadDetalle = new PropiedadDetalle();

                int id;
                if (this.SelectedItem == null)
                {
                    return;
                }

                id = this.SelectedItem().Id;

                PropiedadDto propiedad = await PropiedadApiClient.GetAsync(id);

                propiedadDetalle.EditMode = true;
                propiedadDetalle.Propiedad = propiedad;

                propiedadDetalle.ShowDialog();

                this.GetAllAndLoad();
            }
            catch (Exception ex)
            {
                this.ProcesarError(ex);
            }
        }

        private async void btnEliminar_click(object sender, EventArgs e)
        {
            try
            {
                int id;
                if (this.SelectedItem != null)
                {
                    id = this.SelectedItem().Id;

                    await PropiedadApiClient.DeleteAsync(id);

                    this.GetAllAndLoad();
                }
            }
            catch (Exception ex)
            {
                this.ProcesarError(ex);
            }
        }


        private async void GetAllAndLoad()
        {
            try
            {
                this.dgvPropiedades.DataSource = null;
                this.dgvPropiedades.DataSource = await PropiedadApiClient.GetAllAsync();

                if (this.dgvPropiedades.Rows.Count > 0)
                {
                    this.dgvPropiedades.Rows[0].Selected = true;
                    this.btnEliminar.Enabled = true;
                    this.btnModificar.Enabled = true;
                }
                else
                {
                    this.btnEliminar.Enabled = false;
                    this.btnModificar.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                this.ProcesarError(ex);
            }
        }

        private void btnCargar_Click(object sender, EventArgs e)
        {
            this.GetAllAndLoad();
        }

        private PropiedadDto SelectedItem()
        {
            PropiedadDto propiedad;
            if (this.dgvPropiedades.SelectedRows.Count > 0)
            {
                propiedad = (PropiedadDto)this.dgvPropiedades.SelectedRows[0].DataBoundItem;

                return propiedad;
            }
            else
            {
                return null;
            }
        }



        private void ProcesarError(Exception ex)
        {
            //TODO: Mejorar implementación para que se vean los mensajes manejados del backend
            Console.WriteLine(ex.ToString());
            MessageBox.Show("Ocurrió un error inesperado.",
                            "Error",
                            MessageBoxButtons.OK,
                            MessageBoxIcon.Error);
        }

     
    }
}
