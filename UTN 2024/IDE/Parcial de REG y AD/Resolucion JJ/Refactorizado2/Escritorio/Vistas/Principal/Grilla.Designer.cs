namespace Jaca.Escritorio
{
    partial class Grilla
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Grilla));
            toolStripContainer1 = new ToolStripContainer();
            tlSysacad = new TableLayoutPanel();
            dgvSysacad = new DataGridView();
            fLPBotonesOpciones = new FlowLayoutPanel();
            btnMostrarPropiedades = new Button();
            btnMostrarTiposPropiedades = new Button();
            flowLayoutPanel1 = new FlowLayoutPanel();
            btnSalir = new Button();
            tsSysacad = new ToolStrip();
            tsbNuevo = new ToolStripButton();
            tsbEditar = new ToolStripButton();
            tsbEliminar = new ToolStripButton();
            toolStripContainer1.ContentPanel.SuspendLayout();
            toolStripContainer1.TopToolStripPanel.SuspendLayout();
            toolStripContainer1.SuspendLayout();
            tlSysacad.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dgvSysacad).BeginInit();
            fLPBotonesOpciones.SuspendLayout();
            flowLayoutPanel1.SuspendLayout();
            tsSysacad.SuspendLayout();
            SuspendLayout();
            // 
            // toolStripContainer1
            // 
            // 
            // toolStripContainer1.ContentPanel
            // 
            toolStripContainer1.ContentPanel.Controls.Add(tlSysacad);
            toolStripContainer1.ContentPanel.Size = new Size(800, 423);
            toolStripContainer1.Dock = DockStyle.Fill;
            toolStripContainer1.Location = new Point(0, 0);
            toolStripContainer1.Name = "toolStripContainer1";
            toolStripContainer1.Size = new Size(800, 450);
            toolStripContainer1.TabIndex = 0;
            toolStripContainer1.Text = "toolStripContainer1";
            // 
            // toolStripContainer1.TopToolStripPanel
            // 
            toolStripContainer1.TopToolStripPanel.Controls.Add(tsSysacad);
            // 
            // tlSysacad
            // 
            tlSysacad.ColumnCount = 2;
            tlSysacad.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100F));
            tlSysacad.ColumnStyles.Add(new ColumnStyle());
            tlSysacad.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 545F));
            tlSysacad.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 207F));
            tlSysacad.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 178F));
            tlSysacad.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 178F));
            tlSysacad.Controls.Add(dgvSysacad, 0, 0);
            tlSysacad.Controls.Add(fLPBotonesOpciones, 0, 1);
            tlSysacad.Controls.Add(flowLayoutPanel1, 5, 1);
            tlSysacad.Dock = DockStyle.Fill;
            tlSysacad.Location = new Point(0, 0);
            tlSysacad.Name = "tlSysacad";
            tlSysacad.RowCount = 2;
            tlSysacad.RowStyles.Add(new RowStyle(SizeType.Percent, 100F));
            tlSysacad.RowStyles.Add(new RowStyle());
            tlSysacad.RowStyles.Add(new RowStyle(SizeType.Absolute, 20F));
            tlSysacad.Size = new Size(800, 423);
            tlSysacad.TabIndex = 0;
            // 
            // dgvSysacad
            // 
            dgvSysacad.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dgvSysacad.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            tlSysacad.SetColumnSpan(dgvSysacad, 6);
            dgvSysacad.Dock = DockStyle.Fill;
            dgvSysacad.Location = new Point(3, 3);
            dgvSysacad.Name = "dgvSysacad";
            dgvSysacad.RowHeadersWidth = 51;
            dgvSysacad.Size = new Size(794, 381);
            dgvSysacad.TabIndex = 0;
            // 
            // fLPBotonesOpciones
            // 
            fLPBotonesOpciones.Controls.Add(btnMostrarPropiedades);
            fLPBotonesOpciones.Controls.Add(btnMostrarTiposPropiedades);
            fLPBotonesOpciones.Location = new Point(3, 390);
            fLPBotonesOpciones.Name = "fLPBotonesOpciones";
            fLPBotonesOpciones.Size = new Size(672, 29);
            fLPBotonesOpciones.TabIndex = 5;
            // 
            // btnMostrarPropiedades
            // 
            btnMostrarPropiedades.Location = new Point(3, 3);
            btnMostrarPropiedades.Name = "btnMostrarPropiedades";
            btnMostrarPropiedades.Size = new Size(98, 23);
            btnMostrarPropiedades.TabIndex = 1;
            btnMostrarPropiedades.Text = "Propiedades";
            btnMostrarPropiedades.UseVisualStyleBackColor = true;
            btnMostrarPropiedades.Click += btnMostrarPropiedades_Click;
            // 
            // btnMostrarTiposPropiedades
            // 
            btnMostrarTiposPropiedades.Location = new Point(107, 3);
            btnMostrarTiposPropiedades.Name = "btnMostrarTiposPropiedades";
            btnMostrarTiposPropiedades.Size = new Size(130, 23);
            btnMostrarTiposPropiedades.TabIndex = 2;
            btnMostrarTiposPropiedades.Text = "Tipos de Propiedades";
            btnMostrarTiposPropiedades.UseVisualStyleBackColor = true;
            btnMostrarTiposPropiedades.Click += btnMostrarTiposPropiedades_Click;
            // 
            // flowLayoutPanel1
            // 
            flowLayoutPanel1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            flowLayoutPanel1.Controls.Add(btnSalir);
            flowLayoutPanel1.Location = new Point(731, 390);
            flowLayoutPanel1.Name = "flowLayoutPanel1";
            flowLayoutPanel1.Size = new Size(66, 30);
            flowLayoutPanel1.TabIndex = 6;
            // 
            // btnSalir
            // 
            btnSalir.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            btnSalir.Location = new Point(3, 3);
            btnSalir.Name = "btnSalir";
            btnSalir.Size = new Size(59, 23);
            btnSalir.TabIndex = 4;
            btnSalir.Text = "Salir";
            btnSalir.UseVisualStyleBackColor = true;
            btnSalir.Click += btnSalir_Click;
            // 
            // tsSysacad
            // 
            tsSysacad.Dock = DockStyle.None;
            tsSysacad.ImageScalingSize = new Size(20, 20);
            tsSysacad.Items.AddRange(new ToolStripItem[] { tsbNuevo, tsbEditar, tsbEliminar });
            tsSysacad.Location = new Point(4, 0);
            tsSysacad.Name = "tsSysacad";
            tsSysacad.Size = new Size(84, 27);
            tsSysacad.TabIndex = 0;
            // 
            // tsbNuevo
            // 
            tsbNuevo.DisplayStyle = ToolStripItemDisplayStyle.Image;
            tsbNuevo.Image = (Image)resources.GetObject("tsbNuevo.Image");
            tsbNuevo.ImageTransparentColor = Color.Magenta;
            tsbNuevo.Name = "tsbNuevo";
            tsbNuevo.Size = new Size(24, 24);
            tsbNuevo.Text = "Nuevo";
            tsbNuevo.Click += tsbNuevo_Click;
            // 
            // tsbEditar
            // 
            tsbEditar.DisplayStyle = ToolStripItemDisplayStyle.Image;
            tsbEditar.Image = (Image)resources.GetObject("tsbEditar.Image");
            tsbEditar.ImageTransparentColor = Color.Magenta;
            tsbEditar.Name = "tsbEditar";
            tsbEditar.Size = new Size(24, 24);
            tsbEditar.Text = "Editar";
            tsbEditar.Click += tsbEditar_Click;
            // 
            // tsbEliminar
            // 
            tsbEliminar.DisplayStyle = ToolStripItemDisplayStyle.Image;
            tsbEliminar.Image = (Image)resources.GetObject("tsbEliminar.Image");
            tsbEliminar.ImageTransparentColor = Color.Magenta;
            tsbEliminar.Name = "tsbEliminar";
            tsbEliminar.Size = new Size(24, 24);
            tsbEliminar.Text = "Eliminar";
            tsbEliminar.Click += tsbEliminar_Click;
            // 
            // Grilla
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(toolStripContainer1);
            Name = "Grilla";
            Text = "Grilla";
            toolStripContainer1.ContentPanel.ResumeLayout(false);
            toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
            toolStripContainer1.TopToolStripPanel.PerformLayout();
            toolStripContainer1.ResumeLayout(false);
            toolStripContainer1.PerformLayout();
            tlSysacad.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)dgvSysacad).EndInit();
            fLPBotonesOpciones.ResumeLayout(false);
            flowLayoutPanel1.ResumeLayout(false);
            tsSysacad.ResumeLayout(false);
            tsSysacad.PerformLayout();
            ResumeLayout(false);
        }

        #endregion

        private ToolStripContainer toolStripContainer1;
        private ToolStrip tsSysacad;
        private TableLayoutPanel tlSysacad;
        private DataGridView dgvSysacad;
        private ToolStripButton tsbNuevo;
        private ToolStripButton tsbEditar;
        private ToolStripButton tsbEliminar;
        private Button btnMostrarPropiedades;
        private Button btnMostrarTiposPropiedades;
        private Button btnSalir;
        private FlowLayoutPanel fLPBotonesOpciones;
        private FlowLayoutPanel flowLayoutPanel1;
    }
}

