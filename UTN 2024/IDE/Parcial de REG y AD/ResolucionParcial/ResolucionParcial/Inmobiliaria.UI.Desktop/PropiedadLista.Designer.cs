namespace Inmobiliaria.UI.Desktop
{
    partial class PropiedadLista
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            dgvPropiedades = new DataGridView();
            btnEliminar = new Button();
            btnModificar = new Button();
            btnAgregar = new Button();
            btnCargar = new Button();
            ((System.ComponentModel.ISupportInitialize)dgvPropiedades).BeginInit();
            SuspendLayout();
            // 
            // dgvPropiedades
            // 
            dgvPropiedades.AllowUserToAddRows = false;
            dgvPropiedades.AllowUserToDeleteRows = false;
            dgvPropiedades.AllowUserToResizeColumns = false;
            dgvPropiedades.AllowUserToResizeRows = false;
            dgvPropiedades.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvPropiedades.Location = new Point(17, 20);
            dgvPropiedades.Margin = new Padding(4, 5, 4, 5);
            dgvPropiedades.Name = "dgvPropiedades";
            dgvPropiedades.ReadOnly = true;
            dgvPropiedades.RowHeadersWidth = 62;
            dgvPropiedades.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvPropiedades.Size = new Size(1109, 660);
            dgvPropiedades.TabIndex = 0;
            // 
            // btnEliminar
            // 
            btnEliminar.Location = new Point(690, 692);
            btnEliminar.Margin = new Padding(4, 5, 4, 5);
            btnEliminar.Name = "btnEliminar";
            btnEliminar.Size = new Size(107, 38);
            btnEliminar.TabIndex = 1;
            btnEliminar.Text = "Eliminar";
            btnEliminar.UseVisualStyleBackColor = true;
            btnEliminar.Click += btnEliminar_click;
            // 
            // btnModificar
            // 
            btnModificar.Location = new Point(824, 692);
            btnModificar.Margin = new Padding(4, 5, 4, 5);
            btnModificar.Name = "btnModificar";
            btnModificar.Size = new Size(107, 38);
            btnModificar.TabIndex = 2;
            btnModificar.Text = "Modificar";
            btnModificar.UseVisualStyleBackColor = true;
            btnModificar.Click += btnModificar_click;
            // 
            // btnAgregar
            // 
            btnAgregar.Location = new Point(961, 692);
            btnAgregar.Margin = new Padding(4, 5, 4, 5);
            btnAgregar.Name = "btnAgregar";
            btnAgregar.Size = new Size(107, 38);
            btnAgregar.TabIndex = 3;
            btnAgregar.Text = "Agregar";
            btnAgregar.UseVisualStyleBackColor = true;
            btnAgregar.Click += btnAgregar_click;
            // 
            // btnCargar
            // 
            btnCargar.Location = new Point(545, 692);
            btnCargar.Margin = new Padding(4, 5, 4, 5);
            btnCargar.Name = "btnCargar";
            btnCargar.Size = new Size(107, 38);
            btnCargar.TabIndex = 4;
            btnCargar.Text = "Cargar";
            btnCargar.UseVisualStyleBackColor = true;
            btnCargar.Click += btnCargar_Click;
            // 
            // PropiedadLista
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1143, 750);
            Controls.Add(btnCargar);
            Controls.Add(btnAgregar);
            Controls.Add(btnModificar);
            Controls.Add(btnEliminar);
            Controls.Add(dgvPropiedades);
            Margin = new Padding(4, 5, 4, 5);
            Name = "PropiedadLista";
            Text = "PropiedadLista";
            Load += PropiedadLista_Load;
            ((System.ComponentModel.ISupportInitialize)dgvPropiedades).EndInit();
            ResumeLayout(false);
        }

        #endregion

        private DataGridView dgvPropiedades;
        private Button btnEliminar;
        private Button btnModificar;
        private Button btnAgregar;
        private Button btnCargar;
    }
}
