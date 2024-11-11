namespace Jaca.Escritorio
{
    partial class TipoPropiedadUI
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
            TituloLabel = new Label();
            DescripcionLabel = new Label();
            DescripcionTextBox = new TextBox();
            CancelarButton = new Button();
            GuardarButton = new Button();
            SuspendLayout();
            // 
            // TituloLabel
            // 
            TituloLabel.AutoSize = true;
            TituloLabel.Font = new Font("Segoe UI", 20.25F, FontStyle.Regular, GraphicsUnit.Point, 0);
            TituloLabel.Location = new Point(27, 9);
            TituloLabel.Name = "TituloLabel";
            TituloLabel.Size = new Size(237, 37);
            TituloLabel.TabIndex = 4;
            TituloLabel.Text = "Tipo de Propiedad";
            // 
            // DescripcionLabel
            // 
            DescripcionLabel.AutoSize = true;
            DescripcionLabel.Location = new Point(60, 66);
            DescripcionLabel.Name = "DescripcionLabel";
            DescripcionLabel.Size = new Size(72, 15);
            DescripcionLabel.TabIndex = 3;
            DescripcionLabel.Text = "Descripción:";
            // 
            // DescripcionTextBox
            // 
            DescripcionTextBox.BackColor = SystemColors.ControlDarkDark;
            DescripcionTextBox.ForeColor = SystemColors.Menu;
            DescripcionTextBox.Location = new Point(155, 63);
            DescripcionTextBox.Name = "DescripcionTextBox";
            DescripcionTextBox.Size = new Size(169, 23);
            DescripcionTextBox.TabIndex = 0;
            // 
            // CancelarButton
            // 
            CancelarButton.BackColor = Color.DarkRed;
            CancelarButton.ForeColor = Color.Cornsilk;
            CancelarButton.Location = new Point(80, 105);
            CancelarButton.Name = "CancelarButton";
            CancelarButton.Size = new Size(75, 23);
            CancelarButton.TabIndex = 2;
            CancelarButton.Text = "Cancelar";
            CancelarButton.UseVisualStyleBackColor = false;
            CancelarButton.Click += CancelarButton_Click;
            // 
            // GuardarButton
            // 
            GuardarButton.BackColor = Color.SteelBlue;
            GuardarButton.ForeColor = Color.Cornsilk;
            GuardarButton.Location = new Point(221, 105);
            GuardarButton.Name = "GuardarButton";
            GuardarButton.Size = new Size(75, 23);
            GuardarButton.TabIndex = 1;
            GuardarButton.Text = "Guardar";
            GuardarButton.UseVisualStyleBackColor = false;
            GuardarButton.Click += GuardarButton_Click;
            // 
            // TipoPropiedadUI
            // 
            AcceptButton = GuardarButton;
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(366, 143);
            Controls.Add(TituloLabel);
            Controls.Add(DescripcionLabel);
            Controls.Add(DescripcionTextBox);
            Controls.Add(CancelarButton);
            Controls.Add(GuardarButton);
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            Name = "TipoPropiedadUI";
            StartPosition = FormStartPosition.CenterParent;
            TopMost = true;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label TituloLabel;
        private Label DescripcionLabel;
        private TextBox DescripcionTextBox;
        private Button CancelarButton;
        private Button GuardarButton;
    }
}