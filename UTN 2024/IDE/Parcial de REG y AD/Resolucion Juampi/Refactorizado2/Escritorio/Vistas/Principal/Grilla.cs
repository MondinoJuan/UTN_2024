using System.Net;

using Jaca.Entidades;
using Jaca.Negocio;

namespace Jaca.Escritorio
{

    public partial class Grilla : Form
    {
        private string entidadListada;

        private Task<IEnumerable<Propiedad>>? listadoPropiedades;
        private Task<IEnumerable<TipoPropiedad>>? listadoTiposPropiedades;

        public Grilla()
        {
            InitializeComponent();
        }

        public IEnumerable<T> LeerEntidades<T>()
        {
            if (typeof(T) == typeof(Propiedad))
            {
                this.listadoPropiedades = PropiedadNegocio.GetAll();
                entidadListada = "Propiedad";
                return (IEnumerable<T>)this.listadoPropiedades.Result;
            }
            else if (typeof(T) == typeof(TipoPropiedad))
            {
                this.listadoTiposPropiedades = TipoPropiedadNegocio.GetAll();
                entidadListada = "TipoPropiedad";
                return (IEnumerable<T>)this.listadoTiposPropiedades.Result;
            }
            else
            {
                entidadListada = "";
                return null;
            }
        }

        private void SeleccionarPrimeraFila()
        {
            if (dgvSysacad.Rows.Count > 0)
            {
                dgvSysacad.Rows[0].Selected = true;
            }
        }

        private async void tsbNuevo_Click(object sender, EventArgs e)
        {
            if (entidadListada == "Propiedad")
            {
                Task<IEnumerable<TipoPropiedad>> task = new Task<IEnumerable<TipoPropiedad>>(LeerEntidades<TipoPropiedad>);
                task.Start();
                IEnumerable<TipoPropiedad> tiposPropiedades = await task;

                if (tiposPropiedades != null)
                {
                    List<(int Id, string Descripcion)> opcionesTiposPropiedades = tiposPropiedades.Select(tipoPropiedad => (tipoPropiedad.Id, tipoPropiedad.Descripcion)).ToList();

                    PropiedadUI nuevaPropiedad = new PropiedadUI(opcionesTiposPropiedades);
                    if (nuevaPropiedad.ShowDialog(this) == DialogResult.OK)
                    {
                        OperacionExitosa operacionExitosa = new OperacionExitosa();
                        operacionExitosa.ShowDialog(this);
                    }
                    btnMostrarPropiedades_Click(sender, e);

                }
                else
                {
                    entidadListada = "";
                }
            }
            else if (entidadListada == "TipoPropiedad")
            {
                TipoPropiedadUI nuevoTipoPropiedad = new TipoPropiedadUI();
                if (nuevoTipoPropiedad.ShowDialog(this) == DialogResult.OK)
                {
                    OperacionExitosa operacionExitosa = new OperacionExitosa();
                    operacionExitosa.ShowDialog(this);
                }
                btnMostrarTiposPropiedades_Click(sender, e);
            }
        }

        private async void tsbEditar_Click(object sender, EventArgs e)
        {
            if (entidadListada == "Propiedad")
            {
                Task<IEnumerable<TipoPropiedad>> task = new Task<IEnumerable<TipoPropiedad>>(LeerEntidades<TipoPropiedad>);
                task.Start();
                IEnumerable<TipoPropiedad> tiposPropiedades = await task;

                if (tiposPropiedades != null)
                {
                    List<(int Id, string Descripcion)> opcionesTiposPropiedades = tiposPropiedades.Select(tipoPropiedad => (tipoPropiedad.Id, tipoPropiedad.Descripcion)).ToList();

                    int filaSeleccionada = dgvSysacad.SelectedRows[0].Index;

                    PropiedadUI editarPropiedad = new PropiedadUI(opcionesTiposPropiedades, listadoPropiedades.Result.ToList()[filaSeleccionada]);

                    if (editarPropiedad.ShowDialog(this) == DialogResult.OK)
                    {
                        OperacionExitosa operacionExitosa = new OperacionExitosa();
                        operacionExitosa.ShowDialog(this);
                    }
                    btnMostrarPropiedades_Click(sender, e);
                }
            }
            else if (entidadListada == "TipoPropiedad")
            {
                int filaSeleccionada = dgvSysacad.SelectedRows[0].Index;

                TipoPropiedadUI editarTipoPropiedad = new TipoPropiedadUI(listadoTiposPropiedades.Result.ToList()[filaSeleccionada]);

                if (editarTipoPropiedad.ShowDialog(this) == DialogResult.OK)
                {
                    OperacionExitosa operacionExitosa = new OperacionExitosa();
                    operacionExitosa.ShowDialog(this);
                }
                btnMostrarTiposPropiedades_Click(sender, e);

            }
        }

        private async void tsbEliminar_Click(object sender, EventArgs e)
        {
            if (entidadListada == "Propiedad")
            {
                ConfirmarOperacion confirmarOperacion = new ConfirmarOperacion();
                if (confirmarOperacion.ShowDialog(this) == DialogResult.OK)
                {
                    int filaSeleccionada = dgvSysacad.SelectedRows[0].Index;

                    var response = await PropiedadNegocio.Delete(listadoPropiedades.Result.ToList()[filaSeleccionada]);

                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        OperacionExitosa operacionExitosa = new OperacionExitosa();
                        operacionExitosa.ShowDialog(this);

                        btnMostrarPropiedades_Click(sender, e);
                    }

                }
            }
            else if (entidadListada == "TipoPropiedad")
            {
                ConfirmarOperacion confirmarOperacion = new ConfirmarOperacion();
                if (confirmarOperacion.ShowDialog(this) == DialogResult.OK)
                {
                    int filaSeleccionada = dgvSysacad.SelectedRows[0].Index;

                    var response = await TipoPropiedadNegocio.Delete(listadoTiposPropiedades.Result.ToList()[filaSeleccionada]);

                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        OperacionExitosa operacionExitosa = new OperacionExitosa();
                        operacionExitosa.ShowDialog(this);

                        btnMostrarTiposPropiedades_Click(sender, e);

                    }
                }
            }
        }

        private async void btnMostrarPropiedades_Click(object sender, EventArgs e)
        {
            Task<IEnumerable<Propiedad>> task = new Task<IEnumerable<Propiedad>>(LeerEntidades<Propiedad>);
            task.Start();

            dgvSysacad.DataSource = await task;
            SeleccionarPrimeraFila();
        }

        private async void btnMostrarTiposPropiedades_Click(object sender, EventArgs e)
        {
            Task<IEnumerable<TipoPropiedad>> task = new Task<IEnumerable<TipoPropiedad>>(LeerEntidades<TipoPropiedad>);
            task.Start();

            dgvSysacad.DataSource = await task;
            SeleccionarPrimeraFila();
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            this.Close();
        }

    }
}