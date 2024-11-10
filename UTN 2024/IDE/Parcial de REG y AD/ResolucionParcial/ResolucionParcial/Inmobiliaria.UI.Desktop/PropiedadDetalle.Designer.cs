namespace Inmobiliaria.UI.Desktop
{
    partial class PropiedadDetalle
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            errorProvider = new ErrorProvider(components);
            lblPrecio = new Label();
            lblM2 = new Label();
            lblCantidadHabitaciones = new Label();
            label5 = new Label();
            nudPrecio = new NumericUpDown();
            nudM2 = new NumericUpDown();
            nudCantidadHabilitaciones = new NumericUpDown();
            bntCancelar = new Button();
            btnGuardar = new Button();
            lblDescripcion = new Label();
            lblTitulo = new Label();
            lblTipoPropiedad = new Label();
            txtDescripcion = new TextBox();
            txtTitulo = new TextBox();
            cboTipoPropiedades = new ComboBox();
            lblFechaAlta = new Label();
            ((System.ComponentModel.ISupportInitialize)errorProvider).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nudPrecio).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nudM2).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nudCantidadHabilitaciones).BeginInit();
            SuspendLayout();
            // 
            // errorProvider
            // 
            errorProvider.ContainerControl = this;
            // 
            // lblPrecio
            // 
            lblPrecio.AutoSize = true;
            lblPrecio.Location = new Point(44, 178);
            lblPrecio.Margin = new Padding(4, 0, 4, 0);
            lblPrecio.Name = "lblPrecio";
            lblPrecio.Size = new Size(60, 25);
            lblPrecio.TabIndex = 0;
            lblPrecio.Text = "Precio";
            // 
            // lblM2
            // 
            lblM2.AutoSize = true;
            lblM2.Location = new Point(44, 230);
            lblM2.Margin = new Padding(4, 0, 4, 0);
            lblM2.Name = "lblM2";
            lblM2.Size = new Size(38, 25);
            lblM2.TabIndex = 2;
            lblM2.Text = "M2";
            // 
            // lblCantidadHabitaciones
            // 
            lblCantidadHabitaciones.AutoSize = true;
            lblCantidadHabitaciones.Location = new Point(44, 282);
            lblCantidadHabitaciones.Margin = new Padding(4, 0, 4, 0);
            lblCantidadHabitaciones.Name = "lblCantidadHabitaciones";
            lblCantidadHabitaciones.Size = new Size(190, 25);
            lblCantidadHabitaciones.TabIndex = 3;
            lblCantidadHabitaciones.Text = "Cantidad Habitaciones";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(44, 477);
            label5.Margin = new Padding(4, 0, 4, 0);
            label5.Name = "label5";
            label5.Size = new Size(0, 25);
            label5.TabIndex = 4;
            // 
            // nudPrecio
            // 
            nudPrecio.DecimalPlaces = 2;
            nudPrecio.Location = new Point(253, 176);
            nudPrecio.Margin = new Padding(4, 5, 4, 5);
            nudPrecio.Name = "nudPrecio";
            nudPrecio.Size = new Size(171, 31);
            nudPrecio.TabIndex = 6;
            // 
            // nudM2
            // 
            nudM2.Location = new Point(253, 228);
            nudM2.Margin = new Padding(4, 5, 4, 5);
            nudM2.Name = "nudM2";
            nudM2.Size = new Size(171, 31);
            nudM2.TabIndex = 7;
            // 
            // nudCantidadHabilitaciones
            // 
            nudCantidadHabilitaciones.Location = new Point(253, 280);
            nudCantidadHabilitaciones.Margin = new Padding(4, 5, 4, 5);
            nudCantidadHabilitaciones.Maximum = new decimal(new int[] { 10, 0, 0, 0 });
            nudCantidadHabilitaciones.Minimum = new decimal(new int[] { 1, 0, 0, 0 });
            nudCantidadHabilitaciones.Name = "nudCantidadHabilitaciones";
            nudCantidadHabilitaciones.Size = new Size(171, 31);
            nudCantidadHabilitaciones.TabIndex = 9;
            nudCantidadHabilitaciones.Value = new decimal(new int[] { 1, 0, 0, 0 });
            // 
            // bntCancelar
            // 
            bntCancelar.Location = new Point(244, 387);
            bntCancelar.Margin = new Padding(4, 5, 4, 5);
            bntCancelar.Name = "bntCancelar";
            bntCancelar.Size = new Size(107, 38);
            bntCancelar.TabIndex = 10;
            bntCancelar.Text = "Cancelar";
            bntCancelar.UseVisualStyleBackColor = true;
            bntCancelar.Click += btnCancelar_click;
            // 
            // btnGuardar
            // 
            btnGuardar.Location = new Point(106, 387);
            btnGuardar.Margin = new Padding(4, 5, 4, 5);
            btnGuardar.Name = "btnGuardar";
            btnGuardar.Size = new Size(107, 38);
            btnGuardar.TabIndex = 11;
            btnGuardar.Text = "Guardar";
            btnGuardar.UseVisualStyleBackColor = true;
            btnGuardar.Click += btnGuardar_Click;
            // 
            // lblDescripcion
            // 
            lblDescripcion.AutoSize = true;
            lblDescripcion.Location = new Point(44, 127);
            lblDescripcion.Margin = new Padding(4, 0, 4, 0);
            lblDescripcion.Name = "lblDescripcion";
            lblDescripcion.Size = new Size(104, 25);
            lblDescripcion.TabIndex = 12;
            lblDescripcion.Text = "Descripción";
            // 
            // lblTitulo
            // 
            lblTitulo.AutoSize = true;
            lblTitulo.Location = new Point(44, 76);
            lblTitulo.Margin = new Padding(4, 0, 4, 0);
            lblTitulo.Name = "lblTitulo";
            lblTitulo.Size = new Size(56, 25);
            lblTitulo.TabIndex = 13;
            lblTitulo.Text = "Título";
            // 
            // lblTipoPropiedad
            // 
            lblTipoPropiedad.AutoSize = true;
            lblTipoPropiedad.Location = new Point(44, 30);
            lblTipoPropiedad.Margin = new Padding(4, 0, 4, 0);
            lblTipoPropiedad.Name = "lblTipoPropiedad";
            lblTipoPropiedad.Size = new Size(134, 25);
            lblTipoPropiedad.TabIndex = 14;
            lblTipoPropiedad.Text = "Tipo Propiedad";
            // 
            // txtDescripcion
            // 
            txtDescripcion.Location = new Point(253, 124);
            txtDescripcion.Margin = new Padding(4, 5, 4, 5);
            txtDescripcion.Name = "txtDescripcion";
            txtDescripcion.Size = new Size(171, 31);
            txtDescripcion.TabIndex = 15;
            // 
            // txtTitulo
            // 
            txtTitulo.Location = new Point(253, 73);
            txtTitulo.Margin = new Padding(4, 5, 4, 5);
            txtTitulo.MaxLength = 50;
            txtTitulo.Name = "txtTitulo";
            txtTitulo.Size = new Size(171, 31);
            txtTitulo.TabIndex = 16;
            // 
            // cboTipoPropiedades
            // 
            cboTipoPropiedades.FormattingEnabled = true;
            cboTipoPropiedades.Location = new Point(253, 27);
            cboTipoPropiedades.Margin = new Padding(4, 5, 4, 5);
            cboTipoPropiedades.Name = "cboTipoPropiedades";
            cboTipoPropiedades.Size = new Size(171, 33);
            cboTipoPropiedades.TabIndex = 17;
            // 
            // lblFechaAlta
            // 
            lblFechaAlta.AutoSize = true;
            lblFechaAlta.Location = new Point(140, 336);
            lblFechaAlta.Margin = new Padding(4, 0, 4, 0);
            lblFechaAlta.Name = "lblFechaAlta";
            lblFechaAlta.Size = new Size(0, 25);
            lblFechaAlta.TabIndex = 18;
            // 
            // PropiedadDetalle
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(471, 494);
            Controls.Add(lblFechaAlta);
            Controls.Add(cboTipoPropiedades);
            Controls.Add(txtTitulo);
            Controls.Add(txtDescripcion);
            Controls.Add(lblTipoPropiedad);
            Controls.Add(lblTitulo);
            Controls.Add(lblDescripcion);
            Controls.Add(btnGuardar);
            Controls.Add(bntCancelar);
            Controls.Add(nudCantidadHabilitaciones);
            Controls.Add(nudM2);
            Controls.Add(nudPrecio);
            Controls.Add(label5);
            Controls.Add(lblCantidadHabitaciones);
            Controls.Add(lblM2);
            Controls.Add(lblPrecio);
            Margin = new Padding(4, 5, 4, 5);
            Name = "PropiedadDetalle";
            Text = "PropiedadDetalle";
            Load += PropiedadDetalle_Load;
            ((System.ComponentModel.ISupportInitialize)errorProvider).EndInit();
            ((System.ComponentModel.ISupportInitialize)nudPrecio).EndInit();
            ((System.ComponentModel.ISupportInitialize)nudM2).EndInit();
            ((System.ComponentModel.ISupportInitialize)nudCantidadHabilitaciones).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private ErrorProvider errorProvider;
        private Label lblPrecio;
        private Label label5;
        private Label lblCantidadHabitaciones;
        private Label lblM2;
        private NumericUpDown nudM2;
        private NumericUpDown nudPrecio;
        private NumericUpDown nudCantidadHabilitaciones;
        private Button btnGuardar;
        private Button bntCancelar;
        private ComboBox cboTipoPropiedades;
        private TextBox txtTitulo;
        private TextBox txtDescripcion;
        private Label lblTipoPropiedad;
        private Label lblTitulo;
        private Label lblDescripcion;
        private Label lblFechaAlta;
    }
}